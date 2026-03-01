import { Router } from "express";
import { AddNewCategory, GetCategories, GetCategoryByID, UpdateCategoryByID } from "../controllers/category.controller";

const router = Router();

router.get("/", GetCategories);
router.post("/", AddNewCategory);
router.get("/:id", GetCategoryByID);
router.put("/:id", UpdateCategoryByID);

export default router;
