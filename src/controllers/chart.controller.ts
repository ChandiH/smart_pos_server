import type { RequestHandler } from "express";
import {
  fetchBranchSalesTotals,
  fetchBranchSalesTotalsForIds,
  fetchBranchesByIds,
  fetchCartTotalsByProductRange,
  fetchMonthlySummaryTotals,
  fetchProductsByIds,
  fetchSalesByBranchAndRange,
  fetchSalesViewByBranchAndRange,
} from "../models/chart.model";

const formatDateLocal = (date: Date) => {
  const year = date.getFullYear();
  const month = `${date.getMonth() + 1}`.padStart(2, "0");
  const day = `${date.getDate()}`.padStart(2, "0");
  return `${year}-${month}-${day}`;
};

const getMonthRange = (year: number, monthIndex: number) => {
  const start = new Date(year, monthIndex, 1);
  const end = new Date(year, monthIndex + 1, 1);
  return { start, end };
};

const getTodayRange = () => {
  const start = new Date();
  start.setHours(0, 0, 0, 0);
  const end = new Date(start);
  end.setDate(end.getDate() + 1);
  return { start, end };
};

const parseYearMonth = (value: string) => {
  const [year, month] = value.split("-").map((part) => Number(part));
  return { year, monthIndex: month - 1 };
};

export const GetDailySalesForbranch: RequestHandler = async (req, res) => {
  const { year_month, branch_id } = req.params;
  try {
    const { year, monthIndex } = parseYearMonth(year_month);
    const { start, end } = getMonthRange(year, monthIndex);
    const sales = await fetchSalesByBranchAndRange(branch_id, start, end);
    const totals = new Map<string, number>();

    sales.forEach((entry) => {
      if (!entry.created_at) {
        return;
      }
      const day = formatDateLocal(entry.created_at);
      const amount = Number(entry.total_amount ?? 0);
      totals.set(day, (totals.get(day) ?? 0) + amount);
    });

    const data = Array.from(totals.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([day, total_sales]) => ({
        day,
        total_sales,
      }));

    return res.status(200).json({ data });
  } catch (err) {
    return res.status(400).json({ error: err });
  }
};

export const GetSalesView: RequestHandler = async (req, res) => {
  const { id } = req.params;
  try {
    const { start, end } = getTodayRange();
    const sales = await fetchSalesViewByBranchAndRange(id, start, end);
    const data = sales.map((entry) => ({
      order_id: entry.order_id,
      customer: entry.customer?.customer_name ?? "Guest Customer",
      cashier_name: entry.employee?.employee_name ?? null,
      branch_name: entry.branch?.branch_city ?? null,
      created_time: entry.created_at ? entry.created_at.toTimeString().split(" ")[0] : null,
      total: Number(entry.total_amount ?? 0),
      payment_method: entry.payment_method,
      total_quantity: entry.product_count ?? 0,
    }));

    return res.status(200).json({ data });
  } catch (err) {
    return res.status(400).json({ error: err });
  }
};

export const GetMonthlySummary: RequestHandler = async (_req, res) => {
  try {
    const now = new Date();
    const { start, end } = getMonthRange(now.getFullYear(), now.getMonth());
    const summary = await fetchMonthlySummaryTotals(start, end);

    if (!summary._count.order_id) {
      return res.status(200).json({ data: [] });
    }

    const data = [
      {
        gross_profit: Number(summary._sum.profit ?? 0),
        net_sale: Number(summary._sum.total_amount ?? 0),
        total_orders: summary._count.order_id,
      },
    ];

    return res.status(200).json({ data });
  } catch (err) {
    return res.status(400).json({ error: err });
  }
};

export const GetTopSellingBranch: RequestHandler = async (req, res) => {
  const { target_month } = req.params;
  try {
    const { year, monthIndex } = parseYearMonth(target_month);
    const currentRange = getMonthRange(year, monthIndex);
    const previousRange = getMonthRange(year, monthIndex - 1);

    const currentTotals = await fetchBranchSalesTotals(currentRange.start, currentRange.end, 3);
    if (!currentTotals.length) {
      return res.status(200).json({ data: [] });
    }

    const branchIds = currentTotals.map((entry) => entry.branch_id);
    const branches = await fetchBranchesByIds(branchIds);
    const branchNameById = new Map(branches.map((branch) => [branch.branch_id, branch.branch_city]));

    const previousTotals = await fetchBranchSalesTotalsForIds(previousRange.start, previousRange.end, branchIds);
    const previousById = new Map(
      previousTotals.map((entry) => [entry.branch_id, Number(entry._sum.total_amount ?? 0)])
    );

    const data = currentTotals.map((entry) => ({
      branch_name: branchNameById.get(entry.branch_id) ?? null,
      current_month_sales: Number(entry._sum.total_amount ?? 0),
      previous_month_sales: previousById.get(entry.branch_id) ?? 0,
    }));

    return res.status(200).json({ data });
  } catch (err) {
    return res.status(400).json({ error: err });
  }
};

export const GetMonths: RequestHandler = async (_req, res) => {
  const now = new Date();
  const months = [0, 1, 2]
    .map((offset) => {
      const date = new Date(now.getFullYear(), now.getMonth() - offset, 1);
      const month = `${date.getMonth() + 1}`.padStart(2, "0");
      return {
        month_name: `${date.getFullYear()}-${month}`,
      };
    })
    .sort((a, b) => b.month_name.localeCompare(a.month_name));

  return res.status(200).json({ data: months });
};

export const GetTopSellingProduct: RequestHandler = async (_req, res) => {
  try {
    const now = new Date();
    const currentRange = getMonthRange(now.getFullYear(), now.getMonth());
    const lastMonthRange = getMonthRange(now.getFullYear(), now.getMonth() - 1);

    const currentMonth = await fetchCartTotalsByProductRange(
      currentRange.start,
      currentRange.end,
      undefined,
      5
    );

    if (!currentMonth.length) {
      return res.status(200).json({ data: [] });
    }

    const productIds = currentMonth.map((entry) => entry.product_id);
    const products = await fetchProductsByIds(productIds);
    const productNameById = new Map(products.map((product) => [product.product_id, product.product_name]));

    const lastMonth = await fetchCartTotalsByProductRange(lastMonthRange.start, lastMonthRange.end, productIds);
    const lastMonthById = new Map(
      lastMonth.map((entry) => [entry.product_id, Number(entry._sum.quantity ?? 0)])
    );

    const data = currentMonth.map((entry) => ({
      product_name: productNameById.get(entry.product_id) ?? null,
      current_month_count: Number(entry._sum.quantity ?? 0),
      last_month_count: lastMonthById.get(entry.product_id) ?? 0,
    }));

    return res.status(200).json({ data });
  } catch (err) {
    return res.status(400).json({ error: err });
  }
};
