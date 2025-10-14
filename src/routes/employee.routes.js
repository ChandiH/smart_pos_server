const express = require("express");
const {
  getEmployees,
  getEmployee,
  updateEmployee,
  getEmployeesByBranch,
  getEmployeesByRole,
  updateEmployeeImage,
} = require("../controllers/employee.controller");
const {
  getUserRoles,
  getAccessList,
  updateUserAccess,
} = require("../controllers/userRole.controller");
const {
  getEmployeeRecordByDate,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDateBranch,
  addEmployeeRecord,
} = require("../controllers/workingHour.controller");

const router = express.Router();

router.get("/", getEmployees);
router.get("/roles", getUserRoles);
router.post("/roles", updateUserAccess);
router.get("/access", getAccessList);
router.get("/role/:id", getEmployeesByRole);
router.get("/branch/:id", getEmployeesByBranch);

//working hour endpoints
router.get("/working-hour/date/:date", getEmployeeRecordByDate);
router.get("/working-hour/branch/:branch_id", getEmployeeRecordByBranch);
router.get(
  "/working-hour/date-branch/:date/:branch_id",
  getEmployeeRecordByDateBranch
);
router.post("/working-hour", addEmployeeRecord);

router.get("/:id", getEmployee);
router.put("/image/:id", updateEmployeeImage);
router.put("/:id", updateEmployee);

module.exports = router;
