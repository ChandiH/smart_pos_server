----
DELETE FROM cart WHERE status = 'pending';
--

-- create a new cart
INSERT INTO sales_history (cashier_id) VALUES (4);

-- Create a function to get the last transaction number
CREATE OR REPLACE FUNCTION fn_get_last_transaction_number()
RETURNS INTEGER as
$body$
    SELECT MAX(transaction_number) FROM sales_history;
$body$
LANGUAGE SQL;
SELECT fn_get_last_transaction_number();

-- add items to the cart
INSERT INTO cart (transaction_number, product_id, quantity) SELECT fn_get_last_transaction_number(), 1, 1;

-- update the cart  subtotal amount
CREATE OR REPLACE FUNCTION update_cart_total_amount()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculate the new total_amount based on quantity and retail_ppu
    NEW.total_amount = NEW.quantity * (
        SELECT retail_ppu FROM product WHERE product_id = NEW.product_id
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER cart_insert_trigger_amount
BEFORE INSERT or update ON cart
FOR EACH ROW
EXECUTE FUNCTION update_cart_total_amount();


-- Create a trigger function to handle cart updates and adjust product quantity
CREATE OR REPLACE FUNCTION update_product_quantity()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- Inserting a new item into the cart
        UPDATE product
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    ELSIF TG_OP = 'UPDATE' THEN
        -- Updating an existing item in the cart
        IF NEW.quantity > OLD.quantity THEN
            -- Increase quantity: Deduct the difference from product quantity
            UPDATE product
            SET quantity = quantity - (NEW.quantity - OLD.quantity)
            WHERE product_id = NEW.product_id;
        ELSIF NEW.quantity < OLD.quantity THEN
            -- Decrease quantity: Add the difference back to product quantity
            UPDATE product
            SET quantity = quantity + (OLD.quantity - NEW.quantity)
            WHERE product_id = NEW.product_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Create a trigger that fires before INSERT or UPDATE on the cart table
CREATE TRIGGER cart_update_trigger
BEFORE INSERT OR UPDATE ON cart
FOR EACH ROW
EXECUTE FUNCTION update_product_quantity();


-- updating the cart quantity of a choosen product
UPDATE cart
SET quantity = 8
WHERE 
transaction_number = (SELECT fn_get_last_transaction_number())
AND product_id = 2; --check with cart id



-- show total in sale_history
-- Create a trigger function to update the total_payment in sales_history
CREATE OR REPLACE FUNCTION update_sales_history_total_payment()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- Calculate the new total_payment for inserts
        INSERT INTO sales_history (transaction_number, total_payment)
        VALUES (NEW.transaction_number, (
            SELECT SUM(cart.quantity * product.retail_ppu)
            FROM cart
            JOIN product ON cart.product_id = product.product_id
            WHERE cart.transaction_number = NEW.transaction_number
        ));
    ELSIF TG_OP = 'UPDATE' THEN
        -- Calculate the new total_payment for updates
        UPDATE sales_history
        SET total_payment = (
            SELECT SUM(cart.quantity * product.retail_ppu)
            FROM cart
            JOIN product ON cart.product_id = product.product_id
            WHERE cart.transaction_number = NEW.transaction_number
        )
        WHERE transaction_number = NEW.transaction_number;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Create a trigger that fires before INSERT or UPDATE on the cart table
CREATE TRIGGER cart_insert_update_trigger
BEFORE INSERT OR UPDATE ON cart
FOR EACH ROW
EXECUTE FUNCTION update_sales_history_total_payment();


-- updating the cart and sales_history status after payment done
-- Create a trigger function to update status in cart and sales_history
CREATE OR REPLACE FUNCTION update_cart_and_sales_status()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the status is changing from 'not paid' to 'paid'
    IF OLD.status = 'not paid' AND NEW.status = 'paid' THEN
        -- Update the status in the cart table
        UPDATE cart
        SET status = 'sold'
        WHERE transaction_number = NEW.transaction_number; 
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Create a trigger that fires before UPDATE on the sales_history table
CREATE TRIGGER sales_history_update_trigger
AFTER UPDATE ON sales_history
FOR EACH ROW
EXECUTE FUNCTION update_cart_and_sales_status();

-- updating the cart and sales_history status after payment done STATEMENT
update sales_history set status='paid' where transaction_number=25;


//create trigger whenever the cart is updated  deleted the total payment of relavant transaction_number will be updated 
in sales_history, and the product quantity will be updated in product table

