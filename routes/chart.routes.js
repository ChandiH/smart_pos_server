const express = require("express");

const {
  getDailySalesForbranch,
  getSalesView,
  getMonthlySummary,
  } = require("../controllers/chart.controller");

const router = express.Router();
router.get("/sale_history/:id",getSalesView);
router.get("/:year_month/:branch_id",getDailySalesForbranch);

router.get("/monthly_summary",getMonthlySummary);


module.exports = router;