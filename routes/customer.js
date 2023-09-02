const express = require("express");
const {
  getCustomers,
  getCustomer,
  addCustomer,
} = require("../controllers/customer");
const router = express.Router();

router.get("/", getCustomers);
router.get("/:id", getCustomer);
router.post("/", addCustomer);

module.exports = router;
