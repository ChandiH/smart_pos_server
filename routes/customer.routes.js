const express = require("express");
const {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
} = require("../controllers/customer.controller");

const router = express.Router();

router.get("/", getCustomers);
router.get("/:id", getCustomer);
router.post("/", addCustomer);
router.put("/:id", updateCustomer);

module.exports = router;
