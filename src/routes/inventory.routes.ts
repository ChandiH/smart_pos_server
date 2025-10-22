import { Router, type RequestHandler } from "express";
import inventoryController from "../controllers/inventory.controller";
import categoryController from "../controllers/category.controller";

type InventoryController = {
  getInventory: RequestHandler;
  getInventoryByBranchId: RequestHandler;
  getInevntoryByProductId: RequestHandler;
  updateInventory: RequestHandler;
};

type CategoryController = {
  getCategories: RequestHandler;
  addCategory: RequestHandler;
};

const {
  getInventory,
  getInventoryByBranchId,
  getInevntoryByProductId,
  updateInventory,
} = inventoryController as InventoryController;

const { getCategories, addCategory } =
  categoryController as CategoryController;

const router = Router();

router.get("/", getInventory);
router.get("/category", getCategories);
router.post("/category", addCategory);
router.get("/product/:id", getInevntoryByProductId);
router.get("/branch/:id", getInventoryByBranchId);
router.post("/", updateInventory);

export default router;
