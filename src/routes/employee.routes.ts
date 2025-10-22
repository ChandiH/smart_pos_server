import { Router } from "express";
import {
  GetEmployees,
  GetEmployeesByRole,
  GetEmployeesByBranch,
  GetEmployee,
  UpdateEmployee,
  UpdateEmployeeImage,
} from "../controllers/employee.controller";
import { GetUserRoles, GetAccessList, UpdateUserAccess } from "../controllers/userRole.controller";
import {
  AddEmployeeRecord,
  GetEmployeeRecordByBranch,
  GetEmployeeRecordByDate,
  GetEmployeeRecordByDateBranch,
} from "../controllers/workingHour.controller";

const router = Router();

router.get("/", GetEmployees);
router.get("/roles", GetUserRoles);
router.post("/roles", UpdateUserAccess);
router.get("/access", GetAccessList);
router.get("/role/:id", GetEmployeesByRole);
router.get("/branch/:id", GetEmployeesByBranch);

// Working hour endpoints.
router.get("/working-hour/date/:date", GetEmployeeRecordByDate);
router.get("/working-hour/branch/:branch_id", GetEmployeeRecordByBranch);
router.get("/working-hour/date-branch/:date/:branch_id", GetEmployeeRecordByDateBranch);
router.post("/working-hour", AddEmployeeRecord);

router.get("/:id", GetEmployee);
router.put("/image/:id", UpdateEmployeeImage);
router.put("/:id", UpdateEmployee);

export default router;
