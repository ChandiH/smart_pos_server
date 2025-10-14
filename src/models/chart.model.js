import { pool } from "../config/config";

const getDailySalesForbranch = (year_month, branch_id) => {
  //SELECT * FROM branch_monthly_sales('2023-09', 1);
  return pool.query(
    "SELECT day,total_sales FROM branch_monthly_sales($1,$2) order by day ",
    [year_month, branch_id]
  );
};

const getSalesView = (id) => {
  return pool.query("SELECT * FROM get_sales_data_by_branch($1)", [id]);
};

const getMonthlySummary = () => {
  return pool.query(
    `select sum(profit) as gross_profit ,sum(total_amount) as net_sale, count(order_id)::Integer as total_orders
    from sales_history
    where to_char(created_at, 'YYYY-MM') = to_char(now()::date, 'YYYY-MM')
	group by to_char(created_at, 'YYYY-MM')
`
  );
};
const getTopSellingBranch = (target_month) => {
  return pool.query("SELECT * FROM get_top_branch_sales($1)", [target_month]);
};

const getMonths = () => {
  return pool.query(`
  SELECT TO_CHAR(date_trunc('month', current_date) - INTERVAL '2 months', 'YYYY-MM') AS month_name
UNION
SELECT TO_CHAR(date_trunc('month', current_date) - INTERVAL '1 month', 'YYYY-MM')
UNION
SELECT TO_CHAR(date_trunc('month', current_date), 'YYYY-MM')
order by month_name desc;
`);
};

const getTopSellingProduct = () => {
  return pool.query(
    `WITH current_month_sales AS (
      SELECT
        p.product_name,
        SUM(CASE WHEN DATE_TRUNC('month', c.created_at) = DATE_TRUNC('month', CURRENT_DATE) THEN c.quantity ELSE 0 END) AS current_month_count
      FROM
        cart c
        LEFT JOIN product p ON p.product_id = c.product_id
      WHERE
        DATE_TRUNC('month', c.created_at) = DATE_TRUNC('month', CURRENT_DATE) 
      GROUP BY
        p.product_name
      ORDER BY
        current_month_count DESC
      LIMIT 5
      
    ),
    last_month_sales AS (
      SELECT
        p.product_name,
        SUM(CASE WHEN DATE_TRUNC('month', c.created_at) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') THEN c.quantity ELSE 0 END) AS last_month_count
      FROM
        cart c
        LEFT JOIN product p ON p.product_id = c.product_id
      WHERE
        DATE_TRUNC('month', c.created_at) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') -- Filter by last month
      GROUP BY
        p.product_name
    )
    SELECT
      cm.product_name,
      cm.current_month_count,
      COALESCE(lm.last_month_count, 0) AS last_month_count
    FROM
      current_month_sales cm
      LEFT JOIN last_month_sales lm ON cm.product_name = lm.product_name
    ORDER BY
      cm.current_month_count DESC;
    `
  );
};

module.exports = {
  getDailySalesForbranch,
  getMonthlySummary,
  getSalesView,
  getTopSellingBranch,
  getMonths,
  getTopSellingProduct,
};
