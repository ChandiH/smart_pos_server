const express = require("express");
const {
  getEmployees,
  getEmployee,
  addEmployee,
  updateEmployee,
} = require("../controllers/employee.controller");
const router = express.Router();

router.get("/", getEmployees);
router.get("/:id", getEmployee);
router.post("/", addEmployee);
router.put("/:id", updateEmployee);

module.exports = router;
