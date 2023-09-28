const express = require("express");
const {
  getEmployees,
  getEmployee,
  updateEmployee,
  getEmployeesByBranch,
  getEmployeesByRole,
} = require("../controllers/employee.controller");
const {
  getUserRoles,
  getAccessList,
  updateUserAccess,
} = require("../controllers/userRole.controller");
const router = express.Router();

router.get("/", getEmployees);
router.get("/roles", getUserRoles);
router.post("/roles", updateUserAccess);
router.get("/access", getAccessList);
router.get("/role/:id", getEmployeesByRole);
router.get("/branch/:id", getEmployeesByBranch);
router.get("/:id", getEmployee);
router.put("/:id", updateEmployee);

module.exports = router;
