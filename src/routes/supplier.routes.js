const express = require("express");
const {
  getSuppliers,
  getSupplier,
  addSupplier,
} = require("../controllers/supplier.controller");
const router = express.Router();

router.get("/", getSuppliers);
router.get("/:id", getSupplier);
router.post("/", addSupplier);

module.exports = router;
