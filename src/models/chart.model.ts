import prisma from "../config/prisma";

export const fetchSalesByBranchAndRange = async (branch_id: string, start: Date, end: Date) => {
  return await prisma.sales_history.findMany({
    where: {
      branch_id,
      created_at: {
        gte: start,
        lt: end,
      },
    },
    select: {
      created_at: true,
      total_amount: true,
    },
  });
};

export const fetchSalesViewByBranchAndRange = async (branch_id: string, start: Date, end: Date) => {
  return await prisma.sales_history.findMany({
    where: {
      branch_id,
      created_at: {
        gte: start,
        lt: end,
      },
    },
    select: {
      order_id: true,
      created_at: true,
      total_amount: true,
      payment_method: true,
      product_count: true,
      customer: {
        select: {
          customer_name: true,
        },
      },
      branch: {
        select: {
          branch_city: true,
        },
      },
      employee: {
        select: {
          employee_name: true,
        },
      },
    },
    orderBy: {
      created_at: "desc",
    },
  });
};

export const fetchMonthlySummaryTotals = async (start: Date, end: Date) => {
  return await prisma.sales_history.aggregate({
    where: {
      created_at: {
        gte: start,
        lt: end,
      },
    },
    _sum: {
      profit: true,
      total_amount: true,
    },
    _count: {
      order_id: true,
    },
  });
};

export const fetchBranchSalesTotals = async (start: Date, end: Date, limit: number) => {
  return await prisma.sales_history.groupBy({
    by: ["branch_id"],
    where: {
      created_at: {
        gte: start,
        lt: end,
      },
    },
    _sum: {
      total_amount: true,
    },
    orderBy: {
      _sum: {
        total_amount: "desc",
      },
    },
    take: limit,
  });
};

export const fetchBranchSalesTotalsForIds = async (start: Date, end: Date, branchIds: string[]) => {
  if (!branchIds.length) {
    return [];
  }

  return await prisma.sales_history.groupBy({
    by: ["branch_id"],
    where: {
      branch_id: {
        in: branchIds,
      },
      created_at: {
        gte: start,
        lt: end,
      },
    },
    _sum: {
      total_amount: true,
    },
  });
};

export const fetchBranchesByIds = async (branchIds: string[]) => {
  if (!branchIds.length) {
    return [];
  }

  return await prisma.branch.findMany({
    where: {
      branch_id: {
        in: branchIds,
      },
    },
    select: {
      branch_id: true,
      branch_city: true,
    },
  });
};

export const fetchCartTotalsByProductRange = async (start: Date, end: Date, productIds?: string[], limit?: number) => {
  const where = {
    ...(productIds?.length
      ? {
          product_id: {
            in: productIds,
          },
        }
      : {}),
    created_at: {
      gte: start,
      lt: end,
    },
  };

  if (limit) {
    return await prisma.cart.groupBy({
      by: ["product_id"],
      where,
      _sum: {
        quantity: true,
      },
      orderBy: {
        _sum: {
          quantity: "desc",
        },
      },
      take: limit,
    });
  }

  return await prisma.cart.groupBy({
    by: ["product_id"],
    where,
    _sum: {
      quantity: true,
    },
  });
};

export const fetchProductsByIds = async (productIds: string[]) => {
  if (!productIds.length) {
    return [];
  }

  return await prisma.product.findMany({
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
};
