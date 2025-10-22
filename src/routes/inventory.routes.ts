import { Router } from "express";
import {
  GetInevntoryByProductId,
  GetInventory,
  GetInventoryByBranchId,
  UpdateInventory,
} from "../controllers/inventory.controller";
import { AddNewCategory, GetCategories } from "../controllers/category.controller";

const router = Router();

router.get("/", GetInventory);
router.get("/category", GetCategories);
router.post("/category", AddNewCategory);
router.get("/product/:id", GetInevntoryByProductId);
router.get("/branch/:id", GetInventoryByBranchId);
router.post("/", UpdateInventory);

export default router;
