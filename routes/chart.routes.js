const express = require("express");

const {
  getDailySalesForbranch,
  getSalesHistoryView,
  getMonthlySummary,
  } = require("../controllers/chart.controller");

const router = express.Router();

router.get("/:year_month/:branch_id",getDailySalesForbranch);
router.get("/sales_history",getSalesHistoryView);
router.get("/monthly_summary",getMonthlySummary);


module.exports = router;