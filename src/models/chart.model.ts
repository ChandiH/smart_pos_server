import prisma from "../config/prisma";

export const getDailySalesForbranch = async (year_month: string, branch_id: string) => {
  return await prisma.$queryRaw`
    SELECT
      TO_CHAR(created_at::date, 'YYYY-MM-DD') AS day,
      SUM(total_amount) AS total_sales
    FROM sales_history
    WHERE branch_id = ${branch_id}::uuid
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
      AND b.branch_id = ${id}::uuid
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
  const getMonthRange = (date: Date) => {
    const start = new Date(Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), 1));
    const end = new Date(Date.UTC(date.getUTCFullYear(), date.getUTCMonth() + 1, 1));
    return { start, end };
  };

  const now = new Date();
  const currentRange = getMonthRange(now);
  const lastMonthAnchor = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth() - 1, 1));
  const lastRange = getMonthRange(lastMonthAnchor);

  const currentMonth = await prisma.cart.groupBy({
    by: ["product_id"],
    where: {
      created_at: {
        gte: currentRange.start,
        lt: currentRange.end,
      },
    },
    _sum: {
      quantity: true,
    },
    orderBy: {
      _sum: {
        quantity: "desc",
      },
    },
    take: 5,
  });

  if (!currentMonth.length) {
    return [];
  }

  const productIds = currentMonth.map((entry) => entry.product_id);
  const products = await prisma.product.findMany({
    where: {
      product_id: {
        in: productIds,
      },
    },
    select: {
      product_id: true,
      product_name: true,
    },
  });

  const productNameById = new Map(products.map((product) => [product.product_id, product.product_name]));

  const lastMonth = await prisma.cart.groupBy({
    by: ["product_id"],
    where: {
      product_id: {
        in: productIds,
      },
      created_at: {
        gte: lastRange.start,
        lt: lastRange.end,
      },
    },
    _sum: {
      quantity: true,
    },
  });

  const lastMonthById = new Map(
    lastMonth.map((entry) => [entry.product_id, Number(entry._sum.quantity ?? 0)])
  );

  return currentMonth.map((entry) => ({
    product_name: productNameById.get(entry.product_id) ?? null,
    current_month_count: Number(entry._sum.quantity ?? 0),
    last_month_count: lastMonthById.get(entry.product_id) ?? 0,
  }));
};
