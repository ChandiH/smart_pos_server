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
