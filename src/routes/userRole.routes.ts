import { Router } from "express";
import {
  AddUserRole,
  DeleteUserRole,
  GetAccessList,
  GetUserRoles,
  UpdateUserAccess,
} from "../controllers/userRole.controller";

const router = Router();

router.get("/", GetUserRoles);
router.post("/", AddUserRole);
router.post("/update", UpdateUserAccess);
router.delete("/:id", DeleteUserRole);
router.get("/access", GetAccessList);

export default router;
