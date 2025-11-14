import { Router } from "express";
import { PrintReciept } from "../controllers/printer.controller";

const router = Router();

router.post("/", PrintReciept);

export default router;
