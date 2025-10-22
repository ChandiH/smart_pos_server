import { Router, type RequestHandler } from "express";
import userRoleController from "../controllers/userRole.controller";

type UserRoleController = {
  getUserRoles: RequestHandler;
  addUserRole: RequestHandler;
  getAccessList: RequestHandler;
  deleteUserRole: RequestHandler;
  updateUserAccess: RequestHandler;
};

const {
  getUserRoles,
  addUserRole,
  getAccessList,
  deleteUserRole,
  updateUserAccess,
} = userRoleController as UserRoleController;

const router = Router();

router.get("/", getUserRoles);
router.post("/", addUserRole);
router.post("/update", updateUserAccess);
router.delete("/:id", deleteUserRole);
router.get("/access", getAccessList);

export default router;
