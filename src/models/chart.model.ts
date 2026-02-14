import prisma from "../config/prisma";

export const getDailySalesForbranch = async (year_month: string, branch_id: string) => {
  return await prisma.$queryRaw`
    SELECT
      TO_CHAR(created_at::date, 'YYYY-MM-DD') AS day,
      SUM(total_amount) AS total_sales
    FROM sales_history
    WHERE branch_id = ${branch_id}
      AND TO_CHAR(created_at, 'YYYY-MM') = ${year_month}
    GROUP BY TO_CHAR(created_at::date, 'YYYY-MM-DD')
    ORDER BY day
  `;
};

export const getSalesView = async (id: string) => {
  return await prisma.$queryRaw`
    SELECT
      s.order_id AS order_id,
      COALESCE(c.customer_name, 'Guest Customer') AS customer,
      e.employee_name AS cashier_name,
      b.branch_city AS branch_name,
      s.created_at::time(0) AS created_time,
      s.total_amount::numeric(1000, 2) AS total,
      s.payment_method AS payment_method,
      s.product_count::integer AS total_quantity
    FROM sales_history s
    LEFT JOIN customer c ON c.customer_id = s.customer_id
    LEFT JOIN branch b ON b.branch_id = s.branch_id
    LEFT JOIN employee e ON s.cashier_id = e.employee_id
    WHERE TO_CHAR(s.created_at, 'YYYY-MM-DD') = TO_CHAR(now()::date, 'YYYY-MM-DD')
      AND b.branch_id = ${id}
    ORDER BY s.created_at DESC
  `;
};

export const getMonthlySummary = async () => {
  return await prisma.$queryRaw`select sum(profit) as gross_profit ,sum(total_amount) as net_sale, count(order_id)::Integer as total_orders
    from sales_history
    where to_char(created_at, 'YYYY-MM') = to_char(now()::date, 'YYYY-MM')
	  group by to_char(created_at, 'YYYY-MM')`;
};

export const getTopSellingBranch = async (target_month: string) => {
  return await prisma.$queryRaw`
    WITH CurrentMonthData AS (
      SELECT
        branch_id,
        TO_CHAR(created_at, 'yyyy-mm') AS year_month,
        SUM(total_amount) AS current_month_sales
      FROM sales_history sh
      WHERE TO_CHAR(created_at, 'YYYY-MM') = ${target_month}
      GROUP BY branch_id, TO_CHAR(created_at, 'yyyy-mm')
      ORDER BY current_month_sales DESC
      LIMIT 3
    )
    SELECT
      b.branch_city AS branch_name,
      cmd.current_month_sales,
      COALESCE(
        SUM(
          CASE
            WHEN TO_CHAR(sh.created_at, 'YYYY-MM') =
              TO_CHAR(TO_DATE(${target_month}, 'yyyy-mm') - INTERVAL '1 MONTH', 'YYYY-MM')
            THEN sh.total_amount
            ELSE 0
          END
        ),
        0
      ) AS previous_month_sales
    FROM CurrentMonthData cmd
    LEFT JOIN sales_history sh
      ON cmd.branch_id = sh.branch_id
      AND TO_CHAR(sh.created_at, 'YYYY-MM') =
        TO_CHAR(TO_DATE(${target_month}, 'yyyy-mm') - INTERVAL '1 MONTH', 'YYYY-MM')
    LEFT JOIN branch b ON b.branch_id = cmd.branch_id
    GROUP BY cmd.branch_id, cmd.current_month_sales, TO_CHAR(sh.created_at, 'yyyy-mm'), b.branch_city
    ORDER BY cmd.current_month_sales DESC
    LIMIT 5
  `;
};

export const getMonths = async () => {
  return await prisma.$queryRaw`
    SELECT TO_CHAR(date_trunc('month', current_date) - INTERVAL '2 months', 'YYYY-MM') AS month_name
    UNION
    SELECT TO_CHAR(date_trunc('month', current_date) - INTERVAL '1 month', 'YYYY-MM')
    UNION
    SELECT TO_CHAR(date_trunc('month', current_date), 'YYYY-MM')
    order by month_name desc;`;
};

export const getTopSellingProduct = async () => {
  return await prisma.$queryRaw`
    WITH current_month_sales AS (
      SELECT
        p.product_name,
        SUM(
          CASE
            WHEN DATE_TRUNC('month', c.created_at::timestamp) = DATE_TRUNC('month', CURRENT_DATE::timestamp)
            THEN c.quantity
            ELSE 0
          END
        ) AS current_month_count
      FROM
        cart c
        LEFT JOIN product p ON p.product_id = c.product_id
      WHERE
        DATE_TRUNC('month', c.created_at::timestamp) = DATE_TRUNC('month', CURRENT_DATE::timestamp)
      GROUP BY
        p.product_name
      ORDER BY
        current_month_count DESC
      LIMIT 5
      
    ),
    last_month_sales AS (
      SELECT
        p.product_name,
        SUM(
          CASE
            WHEN DATE_TRUNC('month', c.created_at::timestamp) =
              DATE_TRUNC('month', (CURRENT_DATE - INTERVAL '1 month')::timestamp)
            THEN c.quantity
            ELSE 0
          END
        ) AS last_month_count
      FROM
        cart c
        LEFT JOIN product p ON p.product_id = c.product_id
      WHERE
        DATE_TRUNC('month', c.created_at::timestamp) =
          DATE_TRUNC('month', (CURRENT_DATE - INTERVAL '1 month')::timestamp)
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
      cm.current_month_count DESC;`;
};
