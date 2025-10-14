import type { RequestHandler } from "express";
import Chart from "../models/chart.model";

type ChartModel = {
  getDailySalesForbranch: (
    yearMonth: string,
    branchId: string
  ) => Promise<{ rows: unknown[] }>;
  getSalesView: (id: string) => Promise<{ rows: unknown[] }>;
  getMonthlySummary: () => Promise<{ rows: unknown[] }>;
  getTopSellingBranch: (targetMonth: string) => Promise<{ rows: unknown[] }>;
  getMonths: () => Promise<{ rows: unknown[] }>;
  getTopSellingProduct: () => Promise<{ rows: unknown[] }>;
};

const chartModel = Chart as ChartModel;

const getDailySalesForbranch: RequestHandler = (req, res) => {
  const { year_month, branch_id } = req.params;
  return chartModel
    .getDailySalesForbranch(year_month, branch_id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getSalesView: RequestHandler = (req, res) => {
  const { id } = req.params;
  return chartModel
    .getSalesView(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getMonthlySummary: RequestHandler = (_req, res) => {
  return chartModel
    .getMonthlySummary()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getTopSellingBranch: RequestHandler = (req, res) => {
  const { target_month } = req.params;
  return chartModel
    .getTopSellingBranch(target_month)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getMonths: RequestHandler = (_req, res) => {
  return chartModel
    .getMonths()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getTopSellingProduct: RequestHandler = (_req, res) => {
  return chartModel
    .getTopSellingProduct()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

export default {
  getDailySalesForbranch,
  getSalesView,
  getMonthlySummary,
  getTopSellingBranch,
  getMonths,
  getTopSellingProduct,
};
