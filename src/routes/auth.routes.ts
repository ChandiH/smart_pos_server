import { Router, type RequestHandler } from "express";
import authController from "../controllers/auth.controller";

type AuthController = {
  login: RequestHandler;
  register: RequestHandler;
  resetPassword: RequestHandler;
};

const { login, register, resetPassword } =
  authController as AuthController;

const router = Router();

router.post("/login", login);
router.post("/register", register);
router.put("/resetPassword", resetPassword);

export default router;
