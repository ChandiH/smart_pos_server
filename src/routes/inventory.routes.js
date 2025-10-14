const express = require("express");
const {
  getInventory,
  getInventoryByBranchId,
  getInevntoryByProductId,
  updateInventory,
} = require("../controllers/inventory.controller");

const {
  getCategories,
  addCategory,
} = require("../controllers/category.controller");
const router = express.Router();

router.get("/", getInventory);
router.get("/category", getCategories);
router.post("/category", addCategory);
router.get("/product/:id", getInevntoryByProductId);
router.get("/branch/:id", getInventoryByBranchId);
router.post("/", updateInventory);
module.exports = router;
