const express = require("express");
const {
  getEmployees,
  getEmployee,
  updateEmployee,
    //insert employee password and username

  //update employee password and username

  //delete employee password and username
} = require("../controllers/employee.controller");
const router = express.Router();

router.get("/", getEmployees);
router.get("/:id", getEmployee);
router.put("/:id", updateEmployee);

module.exports = router;
