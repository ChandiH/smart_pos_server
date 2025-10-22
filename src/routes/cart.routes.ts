import { Router, type RequestHandler } from "express";
import cartController from "../controllers/cart.controller";

type CartController = {
  insertSalesData: RequestHandler;
  getRewardsPointsPercentage: RequestHandler;
  updateRewardsPointsPercentage: RequestHandler;
};

const {
  insertSalesData,
  getRewardsPointsPercentage,
  updateRewardsPointsPercentage,
} = cartController as CartController;

const router = Router();

router.post("/insert", insertSalesData);
router.get("/rewards-points-percentage", getRewardsPointsPercentage);
router.put("/rewards-points-percentage", updateRewardsPointsPercentage);

export default router;
