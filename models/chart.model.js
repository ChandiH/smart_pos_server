const pool = require("../config/config");

// call daily chart
const getDailySalesForbranch = (year_month,branch_id) => {
  //SELECT * FROM branch_monthly_sales('2023-09', 1);
  return pool.query("SELECT day,total_sales FROM branch_monthly_sales($1,$2) order by day ", [year_month ,branch_id]);
}

const getSalesHistoryView = () => {
  return pool.query(
   `select 
   s.order_id as order_id , 
   COALESCE(c.customer_name, 'Guest Customer') as customer,
   e.employee_name as cashier_name,
   b.branch_city as branch_name, 
      s.created_at::time(0) as time,
   s.total_amount::numeric(1000,2) as total,
   p.payment_method_name as payment_method,
   s.product_count as total_quantity
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
	   
	   
   order by
   s.order_id desc
   limit 25
   `
  );
}

getMonthlySummary = () => {
  return pool.query(
    `select sum(profit) as gross_profit ,sum(total_amount) as net_sale, count(order_id) as total_orders
    from sales_history
    where  TO_CHAR(created_at, 'YYYY-MM') = TO_CHAR(now()::date, 'YYYY-MM')
    group by TO_CHAR(now()::date, 'YYYY-MM')`
  );
}


module.exports = {
  getDailySalesForbranch,
  getSalesHistoryView,
  getMonthlySummary,
};

