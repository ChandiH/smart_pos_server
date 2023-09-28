const express = require("express");
const {
  getEmployees,
  getEmployee,
  updateEmployee,
} = require("../controllers/employee.controller");
const {
  getUserRoles,
  getAccessList,
  updateUserAccess,
  checkAccess,
} = require("../controllers/userRole.controller");
const router = express.Router();

router.get("/", getEmployees);
router.get("/roles", getUserRoles);
router.post("/roles", updateUserAccess);
router.get("/access", getAccessList);
router.post("/check-access", checkAccess);
router.get("/:id", getEmployee);
router.put("/:id", updateEmployee);

module.exports = router;
