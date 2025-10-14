CREATE OR REPLACE PROCEDURE insert_sales_data_and_update(
    sales_data jsonb
) LANGUAGE plpgsql AS $$
DECLARE
    order_data jsonb;
    items jsonb;
    item jsonb;
	
    order_number integer;
    branches_id INTEGER;
BEGIN
    order_data := sales_data->'order';
    INSERT INTO sales_history (order_id, customer_id, cashier_id, total_amount, profit, payment_method_id, reference_id,
    branch_id,rewards_points,product_count)
    SELECT
        (MAX(order_id) + 1),
        (order_data->>'customer_id')::integer,
        (order_data->>'cashier_id')::integer,
        (order_data->>'total_amount')::numeric,
        (order_data->>'profit')::numeric,
        (order_data->>'payment_method_id')::integer,
        (order_data->>'reference_id'),
        (order_data->>'branch_id')::integer,
        (order_data->>'rewards_points')::numeric,
        (order_data->>'product_count')::integer
    FROM sales_history
    RETURNING order_id INTO order_number;

    IF (order_data->>'customer_id')::integer IS NOT NULL THEN
        UPDATE customer
        SET visit_count = visit_count + 1
        WHERE customer_id = (order_data->>'customer_id')::integer;
        UPDATE customer
        SET rewards_points = rewards_points +(order_data->>'rewards_points')::numeric
        WHERE customer_id =(order_data->>'customer_id')::integer;
    END IF;

    items := sales_data->'products';
    FOR item IN SELECT * FROM jsonb_array_elements(items)
    LOOP
        INSERT INTO cart (order_id, product_id, quantity)
        VALUES (
            order_number,
            (item->>'product_id')::integer,
            (item->>'quantity')::integer
        );		
		UPDATE inventory
        SET quantity = quantity - (item->>'quantity')::integer
        WHERE product_id = (item->>'product_id')::integer AND branch_id =  (order_data->>'branch_id')::integer;
		UPDATE cart
        SET sub_total_amount = 
            (item->>'quantity')::numeric * (SELECT retail_price FROM product WHERE product_id = (item->>'product_id')::integer) -
            (SELECT discount FROM product WHERE product_id = (item->>'product_id')::integer)
        WHERE order_id = order_number AND product_id = (item->>'product_id')::integer;
    END LOOP;
END;
$$;
------------------------------------------------------------------------------------------------------------------------
-- chart_for_daily_sales
CREATE OR REPLACE FUNCTION branch_monthly_sales(
    target_month text,
    target_branch_id integer
)
RETURNS TABLE (day text, total_sales numeric) AS $$
BEGIN
    RETURN QUERY (
        SELECT
            To_char( created_at::date,'YYYY-MM-DD') AS day,
            SUM(total_amount) AS total_sales
        FROM
            sales_history 
        WHERE
            branch_id = target_branch_id
            AND TO_CHAR(created_at, 'YYYY-MM') = target_month  
        GROUP BY
           To_char( created_at::date,'YYYY-MM-DD')
    );
END;
$$ LANGUAGE plpgsql;
------------------------------------------------------------------------------------------------------------------------
--Top 5 products with highest sales
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
        b.branch_city::TEXT
    ORDER BY
        total_quantity DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;
------------------------------------------------------------------------------------------------------------------------
--Sales History Today for current user
CREATE OR REPLACE FUNCTION get_sales_data_by_branch(id integer)
RETURNS TABLE (
    order_id integer,
    customer varchar(255),
    cashier_name  varchar(255),
    branch_name  varchar(255),
    created_time time(0),
    total numeric(1000, 2),
    payment_method  varchar(255),
    total_quantity integer
) AS $$
BEGIN
    RETURN QUERY
    SELECT

   s.order_id as order_id , 
   COALESCE(c.customer_name, 'Guest Customer') as customer,
   e.employee_name as cashier_name,
   b.branch_city as branch_name, 
   s.created_at::time(0) as time,
   s.total_amount::numeric(1000,2) as total,
   p.payment_method_name as payment_method,
   s.product_count::integer as total_quantity
   from sales_history s 
   left join
   customer c
   on 
   c.customer_id = s.customer_id	
   left join 
   branch b
   on
	   b.branch_id = s.branch_id
	   left join 
	   payment_method p
	   on  p.payment_method_id = s.payment_method_id
	   left join
	   employee e
	   on s.cashier_id = e.employee_id
	   
     where to_char(s.created_at, 'YYYY-MM-DD') = to_char(now()::date, 'YYYY-MM-DD')  
     and b.branch_id = id
   order by 
   s.order_id desc;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------
--Top 3 branches with highest sales
CREATE OR REPLACE FUNCTION get_top_branch_sales(target_month text)
RETURNS TABLE (
	branch_name varchar(255),	
    current_month_sales NUMERIC,
    previous_month_sales NUMERIC 
)
AS $$
BEGIN
    RETURN QUERY
    WITH CurrentMonthData AS (
        SELECT
            branch_id,
            TO_CHAR(created_at, 'yyyy-mm') AS year_month,
            SUM(total_amount) AS current_month_sales        FROM
            sales_history sh
        WHERE
            TO_CHAR(created_at, 'YYYY-MM') = target_month
        GROUP BY
            branch_id, TO_CHAR(created_at, 'yyyy-mm')
        ORDER BY
            current_month_sales desc
        LIMIT 3
    )
   SELECT
	b.branch_city as branch_name,
  cmd.current_month_sales,
    COALESCE(SUM(CASE WHEN TO_CHAR(sh.created_at, 'YYYY-MM') = TO_CHAR(TO_DATE(target_month, 'yyyy-mm') - INTERVAL '1 MONTH', 'YYYY-MM') THEN sh.total_amount ELSE 0 END), 0) AS previous_month_sales
	FROM
    CurrentMonthData cmd
LEFT JOIN
    sales_history sh ON cmd.branch_id = sh.branch_id
    AND TO_CHAR(sh.created_at, 'YYYY-MM') = TO_CHAR(TO_DATE(target_month,'yyyy-mm') - INTERVAL '1 MONTH', 'YYYY-MM')
left join
branch b
on b.branch_id = cmd.branch_id
GROUP BY
    cmd.branch_id, cmd.current_month_sales,TO_CHAR(sh.created_at, 'yyyy-mm'),b.branch_city
ORDER BY
    cmd.current_month_sales DESC
LIMIT 5;

END;
$$
LANGUAGE PLPGSQL;
