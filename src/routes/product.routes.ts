import { Router } from "express";
import {
  AddProduct,
  AddProductVariants,
  AddProductWithVariants,
  DeleteProduct,
  DeleteProductVariants,
  GetProduct,
  GetProducts,
  GetProductsBySupplierId,
  GetProductsWithCategory,
  UpdateProduct,
  UpdateProductVariants,
} from "../controllers/product.controller";

const router = Router();

router.get("/", GetProducts);
router.post("/", AddProduct);
router.post("/withvariants", AddProductWithVariants);
router.get("/withcategory", GetProductsWithCategory);
router.get("/supplier/:id", GetProductsBySupplierId);
router.post("/variants", AddProductVariants);
router.put("/variants", UpdateProductVariants);
router.delete("/variants/:id", DeleteProductVariants);
router.get("/:id", GetProduct);
router.put("/:id", UpdateProduct);
router.delete("/:id", DeleteProduct);

export default router;
