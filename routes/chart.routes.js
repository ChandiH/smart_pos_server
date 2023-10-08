const express = require("express");

const {
  getDailySalesForbranch,
  getSalesView,
  getMonthlySummary,
  getTopSellingBranch,
} = require("../controllers/chart.controller");

const router = express.Router();
router.get("/sale_history/:id", getSalesView);
router.get("/:year_month/:branch_id", getDailySalesForbranch);
router.get("/monthly_summary", getMonthlySummary);
router.get("/:target_month", getTopSellingBranch);

module.exports = router;
