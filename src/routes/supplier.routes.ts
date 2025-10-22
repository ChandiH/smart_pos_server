import { Router } from "express";
import { AddSupplier, GetSupplier, GetSuppliers } from "../controllers/supplier.controller";

const router = Router();

router.get("/", GetSuppliers);
router.get("/:id", GetSupplier);
router.post("/", AddSupplier);

export default router;
