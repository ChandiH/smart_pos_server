import { Router } from "express";
import {
  GetRewardsPointsPercentage,
  InsertSalesData,
  UpdateRewardsPointsPercentage,
} from "../controllers/cart.controller";

const router = Router();

router.post("/insert", InsertSalesData);
router.get("/rewards-points-percentage", GetRewardsPointsPercentage);
router.put("/rewards-points-percentage", UpdateRewardsPointsPercentage);

export default router;
