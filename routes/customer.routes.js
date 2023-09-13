const express = require("express");
const {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
  findEmail,
  findPhone,
} = require("../controllers/customer.controller");

const router = express.Router();

router.get("/", getCustomers);
router.get("/email/:email", findEmail);
router.get("/phone/:phone", findPhone);
router.get("/:id", getCustomer);
router.post("/", addCustomer);
router.put("/:id", updateCustomer);

module.exports = router;
