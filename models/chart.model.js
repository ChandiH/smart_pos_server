const pool = require("../config/config");

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

module.exports = {
  getDailySalesForbranch,
  getMonthlySummary,
  getSalesView,
  getTopSellingBranch,
  getMonths,
};
