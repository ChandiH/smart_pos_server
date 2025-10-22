import { Router, type RequestHandler } from "express";
import inventoryController from "../controllers/inventory.controller";
import { addNewCategory, getCategories } from "../controllers/category.controller";

type InventoryController = {
  getInventory: RequestHandler;
  getInventoryByBranchId: RequestHandler;
  getInevntoryByProductId: RequestHandler;
  updateInventory: RequestHandler;
};

const { getInventory, getInventoryByBranchId, getInevntoryByProductId, updateInventory } =
  inventoryController as InventoryController;

const router = Router();

router.get("/", getInventory);
router.get("/category", getCategories);
router.post("/category", addNewCategory);
router.get("/product/:id", getInevntoryByProductId);
router.get("/branch/:id", getInventoryByBranchId);
router.post("/", updateInventory);

export default router;
