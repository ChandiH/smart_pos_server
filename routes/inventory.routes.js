const express = require("express");
const {
  getInventory,
  getInventoryByBranchId,
  getInevntoryByProductId,
} = require("../controllers/inventory.controller");

const router = express.Router();

router.get("/", getInventory);
router.get("/product/:id", getInevntoryByProductId);
router.get("/branch/:id", getInventoryByBranchId);

module.exports = router;
