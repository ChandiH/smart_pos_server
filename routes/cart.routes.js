const express = require("express");
const { insertSalesData } = require("../controllers/cart.controller");
const router = express.Router();

router.post("/insert", insertSalesData);

module.exports = router;
