const express = require("express");

const {
  getDailySalesForbranch,
  } = require("../controllers/chart.controller");

const router = express.Router();

router.get("/:year_month/:branch_id",getDailySalesForbranch);



module.exports = router;