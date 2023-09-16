const express = require("express");
const {
  getProducts,
  getProduct,
  addProduct,
  updateProduct,
  getProductsWithCategory,
  getProductsBySupplierId,
} = require("../controllers/product.controller");
const router = express.Router();

router.get("/", getProducts);
router.get("/withcategory", getProductsWithCategory);
router.get("/supplier/:id", getProductsBySupplierId);
router.get("/:id", getProduct);
router.post("/", addProduct);
router.put("/:id", updateProduct);

module.exports = router;
