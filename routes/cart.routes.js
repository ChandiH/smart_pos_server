const express = require("express");
const { insertSalesData , getRewardsPointsPercentage } = require("../controllers/cart.controller");
const router = express.Router();

router.post("/insert", insertSalesData);
router.get("/rewards-points-percentage", getRewardsPointsPercentage);

module.exports = router;
