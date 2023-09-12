const express = require("express");
const {
  getProducts,
  getProduct,
  addProduct,
  updateProduct,
  getProductsWithCategory,
} = require("../controllers/product.controller");
const router = express.Router();

router.get("/", getProducts);
router.get("/withcategory", getProductsWithCategory);
router.get("/:id", getProduct);
router.post("/", addProduct);
router.put("/:id", updateProduct);

module.exports = router;
