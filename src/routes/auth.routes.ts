import { Router } from "express";
import { Login, RegisterUser, ResetPasswordHandler } from "../controllers/auth.controller";

const router = Router();

router.post("/login", Login);
router.post("/register", RegisterUser);
router.put("/resetPassword", ResetPasswordHandler);

export default router;
