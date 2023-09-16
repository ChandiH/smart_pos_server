--create tables
--setPK
--data
--query




-- view data in sales_history
-- INSERT INTO sales_history (cashier_id) VALUES (4);

-- view data in cart,product,sales_history
-- INSERT INTO cart (transaction_number, product_id, quantity) SELECT fn_get_last_transaction_number(), 1, 1;

-- view data in cart,product,sales_history
-- UPDATE cart SET quantity = 8 WHERE transaction_number = (SELECT fn_get_last_transaction_number())AND product_id = 1; --check with cart id

--view status in sales_history and cart
-- update sales_history set status='paid' where transaction_number = (SELECT fn_get_last_transaction_number());


--- total amount ekai e tike frontend eken enawa e tika kelinm add karann tynne database 1ta
-- e id eka aran cart ekata gannawa badu tika e ekkama products adu wenawa
-- updated on wunama trigger eka fire wenawa
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