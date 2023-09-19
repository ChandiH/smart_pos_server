const express = require("express");
const {
  getInventory,
  getInventoryByBranchId,
  getInevntoryByProductId,
  updateInventory,
} = require("../controllers/inventory.controller");

const { getCategories } = require("../controllers/category.controller");
const router = express.Router();

router.get("/", getInventory);
router.get("/category", getCategories);
router.get("/product/:id", getInevntoryByProductId);
router.get("/branch/:id", getInventoryByBranchId);
router.post("/", updateInventory);
module.exports = router;
