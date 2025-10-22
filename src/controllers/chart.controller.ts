import type { RequestHandler } from "express";
import {
  getDailySalesForbranch,
  getMonthlySummary,
  getMonths,
  getSalesView,
  getTopSellingBranch,
  getTopSellingProduct,
} from "../models/chart.model";

export const GetDailySalesForbranch: RequestHandler = async (req, res) => {
  const { year_month, branch_id } = req.params;
  return await getDailySalesForbranch(year_month, branch_id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetSalesView: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getSalesView(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetMonthlySummary: RequestHandler = async (_req, res) => {
  return await getMonthlySummary()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetTopSellingBranch: RequestHandler = async (req, res) => {
  const { target_month } = req.params;
  return await getTopSellingBranch(target_month)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetMonths: RequestHandler = async (_req, res) => {
  return await getMonths()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetTopSellingProduct: RequestHandler = async (_req, res) => {
  return await getTopSellingProduct()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
