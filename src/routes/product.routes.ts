import { Router } from "express";
import {
  AddProduct,
  DeleteProduct,
  GetProduct,
  GetProducts,
  GetProductsBySupplierId,
  GetProductsWithCategory,
  UpdateProduct,
  UpdateProductDiscount,
} from "../controllers/product.controller";

const router = Router();

router.get("/", GetProducts);
router.post("/", AddProduct);
router.get("/withcategory", GetProductsWithCategory);
router.get("/supplier/:id", GetProductsBySupplierId);
router.put("/discount/:id", UpdateProductDiscount);
router.get("/:id", GetProduct);
router.put("/:id", UpdateProduct);
router.delete("/:id", DeleteProduct);

export default router;
