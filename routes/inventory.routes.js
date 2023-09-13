const express = require("express");
const {
  getInventory,
  getInventoryByBranchId,
  getInevntoryByProductId,
} = require("../controllers/inventory.controller");

const {
  getCategories,
  getCategory,
  addCategory,
} = require("../controllers/category.controller");

const router = express.Router();

router.get("/", getInventory);
router.get("/product/:id", getInevntoryByProductId);
router.get("/branch/:id", getInventoryByBranchId);

// cateogry details
router.get("/category", getCategories);
router.post("/category", addCategory);
router.get("/category/:id", getCategory);

module.exports = router;
