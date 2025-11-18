import { Router } from "express";
import { PrintRaw, PrintReceipt } from "../controllers/printer.controller";

const router = Router();

router.post("/raw", PrintRaw);
router.post("/receipt", PrintReceipt);

export default router;
