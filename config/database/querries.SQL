----
DELETE FROM cart WHERE status = 'pending';
--


CREATE OR REPLACE FUNCTION fn_insert_sales_history(cashier_id INTEGER) 
RETURNS void as
$body$
	INSERT INTO sales_history (cashier_id) VALUES (cashier_id);
$body$
LANGUAGE SQL;
SELECT fn_insert_sales_history(4);



CREATE OR REPLACE FUNCTION fn_get_last_transaction_number()
RETURNS INTEGER as
$body$
    SELECT MAX(transaction_number) FROM sales_history;
$body$
LANGUAGE SQL;
SELECT fn_get_last_transaction_number();



INSERT INTO cart (transaction_number, product_id, quantity) SELECT fn_get_last_transaction_number(), 1, 1;

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

UPDATE cart
SET quantity = 8
WHERE 
transaction_number = (SELECT fn_get_last_transaction_number())
AND product_id = 2; --check with cart id


//create trigger whenever the cart is updated  deleted the total payment of relavant transaction_number will be updated 
in sales_history, and the product quantity will be updated in product table

