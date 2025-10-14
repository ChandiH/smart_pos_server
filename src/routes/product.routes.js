const express = require("express");
const {
  getProducts,
  getProduct,
  addProduct,
  deleteProduct,
  updateProduct,
  getProductsWithCategory,
  getProductsBySupplierId,
  updateProductDiscount,
} = require("../controllers/product.controller");
const router = express.Router();

router.get("/", getProducts);
router.post("/", addProduct);
router.get("/withcategory", getProductsWithCategory);
router.get("/supplier/:id", getProductsBySupplierId);
router.put("/discount/:id", updateProductDiscount);
router.get("/:id", getProduct);
router.put("/:id", updateProduct);

router.delete("/:id", deleteProduct);

module.exports = router;
