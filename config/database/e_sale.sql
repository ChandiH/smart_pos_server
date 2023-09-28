-- Create or replace a function to update inventory when new items are added to the cart
CREATE OR REPLACE FUNCTION update_inventory_on_cart_insert()
RETURNS TRIGGER AS $$
DECLARE
    branches_id INTEGER;
BEGIN
    -- Get the branch_id associated with the employee_id in the employee table
    SELECT e.branch_id INTO branches_id
    FROM employee e
    WHERE e.employee_id = (
        SELECT s.cashier_id
        FROM sales_history s
        WHERE s.order_id = NEW.order_id
    );

    -- Decrease the inventory quantity for the specific product and branch
    UPDATE inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id AND branch_id = branches_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that fires the function when a new row is inserted into the cart table
CREATE TRIGGER cart_insert_trigger
AFTER INSERT ON cart
FOR EACH ROW
EXECUTE FUNCTION update_inventory_on_cart_insert();



------------------------------------------------------------------------------------------------------------------------

-- Create a trigger function to update the cart's total_amount
CREATE OR REPLACE FUNCTION update_cart_total_amount()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculate the total_amount based on quantity and product price
    NEW.sub_total_amount = 
        NEW.quantity * (SELECT retail_price FROM product WHERE product_id = NEW.product_id) -  (SELECT discount FROM product WHERE product_id = NEW.product_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER cart_total_amount_trigger
before INSERT ON cart
FOR EACH ROW
EXECUTE FUNCTION update_cart_total_amount();

------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION insert_sales_data(
    sales_data jsonb
) RETURNS void AS $$
DECLARE
    order_data jsonb;
    items jsonb;
    order_number integer;
    item jsonb;
BEGIN
    -- Extract order information from the input JSON
    order_data := sales_data->'order';
    SELECT (MAX(order_id) + 1) INTO order_number FROM sales_history;

    -- Cast customer_id and payment_method_id to integer
    INSERT INTO sales_history (order_id, customer_id, cashier_id, total_amount, profit, payment_method_id, reference_id,branch_id)
    VALUES (
        order_number,
        (order_data->>'customer_id')::integer,
        (order_data->>'cashier_id')::integer,
        (order_data->>'total_amount')::numeric,
        (order_data->>'profit')::numeric,
        (order_data->>'payment_method_id')::integer,
        (order_data->>'reference_id'),
        (order_data->>'branch_id')::integer
    );

    -- Extract the array of items from the input JSON
    items := sales_data->'products';

    -- Loop through the items and insert data into cart table
    FOR item IN SELECT * FROM jsonb_array_elements(items)
    LOOP
        INSERT INTO cart (order_id, product_id, quantity)
        VALUES (
            order_number,
            (item->>'product_id')::integer,
            (item->>'quantity')::integer
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------
-- chart_for_daily_sales
CREATE OR REPLACE FUNCTION branch_monthly_sales(
    target_month text,
    target_branch_id integer
)
RETURNS TABLE (day timestamp with time zone, total_sales numeric) AS $$
BEGIN
    RETURN QUERY (
        SELECT
            sh.created_at AS day,
            SUM(sh.total_amount) AS total_sales
        FROM
            sales_history sh
        JOIN
            employee e ON sh.cashier_id = e.employee_id
        WHERE
            e.branch_id = target_branch_id
            AND TO_CHAR(sh.created_at, 'YYYY-MM') = target_month
        GROUP BY
            sh.created_at
        ORDER BY
            sh.created_at
    );
END;
$$ LANGUAGE plpgsql;


------------------------------------------------------------------------------------------------------------------------
-- chart_for_top_products
CREATE OR REPLACE FUNCTION get_top_5_products_in_branch(
	branch_id_input integer)
    RETURNS TABLE(product_id integer, total_quantity integer, product_name text, branch_id integer, branch_city text) 
    
AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.product_id,
        SUM(c.quantity) AS total_quantity,
        p.product_name::TEXT,
        sh.branch_id,
        b.branch_city::TEXT  
    FROM
        cart c
    JOIN
        sales_history sh ON c.order_id = sh.order_id
    LEFT JOIN
        product p ON p.product_id = c.product_id
    LEFT JOIN
        branch b ON b.branch_id = sh.branch_id
    WHERE
        DATE_TRUNC('month', sh.created_at) = DATE_TRUNC('month', CURRENT_DATE)
        AND sh.branch_id = branch_id_input
    GROUP BY
        c.product_id,
        p.product_name::TEXT,
        sh.branch_id,
        b.branch_city::TEXT  -- Cast branch_city to TEXT
    ORDER BY
        total_quantity DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------
--update sales_history table after inserting into cart table
CREATE OR REPLACE FUNCTION update_sales_history()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE sales_history
    SET product_count = (
        SELECT SUM(quantity)
        FROM cart
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER update_sales_history_trigger
AFTER INSERT ON cart
FOR EACH ROW
EXECUTE FUNCTION update_sales_history();