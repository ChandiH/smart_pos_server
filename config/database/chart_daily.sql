CREATE OR REPLACE FUNCTION get_daily(
    target_month date,
    target_branch_id integer
)
RETURNS TABLE (day date, total_sales numeric) AS $$
BEGIN
    RETURN QUERY (
        SELECT
            DATE_TRUNC('day', sh.created_at)::date AS day,
            SUM(sh.total_amount) AS total_sales
        FROM
            sales_history sh
        JOIN
            employee e ON sh.cashier_id = e.employee_id
        WHERE
            e.branch_id = target_branch_id
            AND DATE_TRUNC('month', sh.created_at) = DATE_TRUNC('month', target_month)
        GROUP BY
            DATE_TRUNC('day', sh.created_at)::date
        ORDER BY
            DATE_TRUNC('day', sh.created_at)::date
    );
END;
$$ LANGUAGE plpgsql;

--SELECT * FROM get_daily('2023-08-01', 1);
