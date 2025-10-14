import { Router, type RequestHandler } from "express";
import categoryController from "../controllers/category.controller";

type CategoryController = {
  getCategories: RequestHandler;
  getCategory: RequestHandler;
  addCategory: RequestHandler;
  updateCategory: RequestHandler;
};

const router = Router();

const { getCategories, getCategory, addCategory, updateCategory } =
  categoryController as CategoryController;

router.get("/", getCategories);
router.post("/", addCategory);
router.get("/:id", getCategory);
router.put("/:id", updateCategory);

export default router;
