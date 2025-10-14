import { Router, type RequestHandler } from "express";
import employeeController from "../controllers/employee.controller";
import userRoleController from "../controllers/userRole.controller";
import workingHourController from "../controllers/workingHour.controller";

type EmployeeController = {
  getEmployees: RequestHandler;
  getEmployee: RequestHandler;
  updateEmployee: RequestHandler;
  getEmployeesByBranch: RequestHandler;
  getEmployeesByRole: RequestHandler;
  updateEmployeeImage: RequestHandler;
};

type UserRoleController = {
  getUserRoles: RequestHandler;
  getAccessList: RequestHandler;
  updateUserAccess: RequestHandler;
};

type WorkingHourController = {
  getEmployeeRecordByDate: RequestHandler;
  getEmployeeRecordByBranch: RequestHandler;
  getEmployeeRecordByDateBranch: RequestHandler;
  addEmployeeRecord: RequestHandler;
};

const {
  getEmployees,
  getEmployee,
  updateEmployee,
  getEmployeesByBranch,
  getEmployeesByRole,
  updateEmployeeImage,
} = employeeController as EmployeeController;

const { getUserRoles, getAccessList, updateUserAccess } =
  userRoleController as UserRoleController;

const {
  getEmployeeRecordByDate,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDateBranch,
  addEmployeeRecord,
} = workingHourController as WorkingHourController;

const router = Router();

router.get("/", getEmployees);
router.get("/roles", getUserRoles);
router.post("/roles", updateUserAccess);
router.get("/access", getAccessList);
router.get("/role/:id", getEmployeesByRole);
router.get("/branch/:id", getEmployeesByBranch);

// Working hour endpoints.
router.get("/working-hour/date/:date", getEmployeeRecordByDate);
router.get("/working-hour/branch/:branch_id", getEmployeeRecordByBranch);
router.get("/working-hour/date-branch/:date/:branch_id", getEmployeeRecordByDateBranch);
router.post("/working-hour", addEmployeeRecord);

router.get("/:id", getEmployee);
router.put("/image/:id", updateEmployeeImage);
router.put("/:id", updateEmployee);

export default router;
