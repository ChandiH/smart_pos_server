import { Router } from "express";
import { PrintRaw, PrintReciept } from "../controllers/printer.controller";

const router = Router();

router.post("/raw", PrintRaw);
router.post("/receipt", PrintReciept);

export default router;
