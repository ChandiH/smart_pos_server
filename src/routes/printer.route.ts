import { Router } from "express";
import { PrintRaw, PrintReciept, OpenDrawerOnly } from "../controllers/printer.controller";

const router = Router();

router.post("/raw", PrintRaw);
router.post("/receipt", PrintReciept);
router.post("/drawer", OpenDrawerOnly);

export default router;
