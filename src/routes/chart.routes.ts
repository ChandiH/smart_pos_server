import { Router } from "express";
import {
  GetDailySalesForbranch,
  GetMonthlySummary,
  GetMonths,
  GetSalesView,
  GetTopSellingBranch,
  GetTopSellingProduct,
} from "../controllers/chart.controller";

const router = Router();

router.get("/sale_history/:id", GetSalesView);
router.get("/:year_month/:branch_id", GetDailySalesForbranch);
router.get("/monthly_summary", GetMonthlySummary);
router.get("/:target_month", GetTopSellingBranch);
router.get("/three/months/now", GetMonths);
router.get("/top/selling/products", GetTopSellingProduct);

export default router;
