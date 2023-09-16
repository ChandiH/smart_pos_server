--INSERT INTO sales_history ( customer_id ,cashier_id ,total_amount,payment_method_id  ,reference_ID ) VALUES ( 1,1,100,1,'1234567890' );

CREATE OR REPLACE FUNCTION fn_get_last_order_id()
RETURNS INTEGER as
$body$
    SELECT MAX(order_id) FROM sales_history;
$body$
LANGUAGE SQL;

-- add items to the cart
--INSERT INTO cart (order_id, product_id, quantity) SELECT fn_get_last_order_id(), 1, 1;

-- Create a trigger function to handle cart updates and adjust inventory quantity
CREATE OR REPLACE FUNCTION update_inventory_quantity()
RETURNS TRIGGER AS $$
DECLARE
    order_branch_id INTEGER;
BEGIN
    -- Find the branch_id associated with the order's cashier_id
    SELECT sh.cashier_id INTO order_branch_id
    FROM sales_history sh
    WHERE sh.order_id = NEW.order_id;
    -- Update the inventory quantity
    UPDATE inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id
      AND branch_id = order_branch_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER cart_insert_trigger
BEFORE INSERT ON cart
FOR EACH ROW
EXECUTE FUNCTION update_inventory_quantity();


-- Create a trigger function to update the cart's total_amount
CREATE OR REPLACE FUNCTION update_cart_total_amount()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculate the total_amount based on quantity and product price
    NEW.sub_total_amount = NEW.quantity * (
        SELECT retail_price FROM product WHERE product_id = NEW.product_id
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER cart_total_amount_trigger
before INSERT ON cart
FOR EACH ROW
EXECUTE FUNCTION update_cart_total_amount();