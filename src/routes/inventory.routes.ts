import { Router } from "express";
import {
  GetInventory,
  GetInventoryByBranchId,
  GetInventoryByProductId,
  GetInventoryWithProduct,
  UpdateInventory,
} from "../controllers/inventory.controller";
import { AddNewCategory, GetCategories } from "../controllers/category.controller";

const router = Router();

router.get("/", GetInventory);
router.get("/category", GetCategories);
router.post("/category", AddNewCategory);
router.get("/product/:id", GetInventoryByProductId);
router.get("/branch/:id", GetInventoryByBranchId);
router.get("/withproduct", GetInventoryWithProduct);
router.post("/", UpdateInventory);

export default router;
