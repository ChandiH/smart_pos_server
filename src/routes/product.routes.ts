import { Router, type RequestHandler } from "express";
import productController from "../controllers/product.controller";

type ProductController = {
  getProducts: RequestHandler;
  getProduct: RequestHandler;
  addProduct: RequestHandler;
  deleteProduct: RequestHandler;
  updateProduct: RequestHandler;
  getProductsWithCategory: RequestHandler;
  getProductsBySupplierId: RequestHandler;
  updateProductDiscount: RequestHandler;
};

const {
  getProducts,
  getProduct,
  addProduct,
  deleteProduct,
  updateProduct,
  getProductsWithCategory,
  getProductsBySupplierId,
  updateProductDiscount,
} = productController as ProductController;

const router = Router();

router.get("/", getProducts);
router.post("/", addProduct);
router.get("/withcategory", getProductsWithCategory);
router.get("/supplier/:id", getProductsBySupplierId);
router.put("/discount/:id", updateProductDiscount);
router.get("/:id", getProduct);
router.put("/:id", updateProduct);
router.delete("/:id", deleteProduct);

export default router;
