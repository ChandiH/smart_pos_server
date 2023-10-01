const express = require("express");
const {
  insertSalesData,
  getRewardsPointsPercentage,
  updateRewardsPointsPercentage,
} = require("../controllers/cart.controller");
const router = express.Router();

router.post("/insert", insertSalesData);
router.get("/rewards-points-percentage", getRewardsPointsPercentage);
router.put("/rewards-points-percentage", updateRewardsPointsPercentage);

module.exports = router;
