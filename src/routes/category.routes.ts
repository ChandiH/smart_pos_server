import { Router } from "express";
import { addNewCategory, getCategories, getCategoryByID, updateCategoryByID } from "../controllers/category.controller";

const router = Router();

router.get("/", getCategories);
router.post("/", addNewCategory);
router.get("/:id", getCategoryByID);
router.put("/:id", updateCategoryByID);

export default router;
