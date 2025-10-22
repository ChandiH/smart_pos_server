import { Router, type RequestHandler } from "express";
import chartController from "../controllers/chart.controller";

type ChartController = {
  getDailySalesForbranch: RequestHandler;
  getSalesView: RequestHandler;
  getMonthlySummary: RequestHandler;
  getTopSellingBranch: RequestHandler;
  getMonths: RequestHandler;
  getTopSellingProduct: RequestHandler;
};

const {
  getDailySalesForbranch,
  getSalesView,
  getMonthlySummary,
  getTopSellingBranch,
  getMonths,
  getTopSellingProduct,
} = chartController as ChartController;

const router = Router();

router.get("/sale_history/:id", getSalesView);
router.get("/:year_month/:branch_id", getDailySalesForbranch);
router.get("/monthly_summary", getMonthlySummary);
router.get("/:target_month", getTopSellingBranch);
router.get("/three/months/now", getMonths);
router.get("/top/selling/products", getTopSellingProduct);

export default router;
