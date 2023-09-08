const express = require("express");
const {
  getProducts,
  getProduct,
  addProduct,
  updateProduct,
} = require("../controllers/product");
const router = express.Router();

router.get("/",  getProducts);
router.get("/:id",  getProduct);
router.post("/", addProduct);
router.put("/:id", updateProduct);

module.exports = router;
