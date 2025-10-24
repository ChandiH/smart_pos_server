import { Router } from "express";
import { AddSupplier, GetSupplier, GetSuppliers, UpdateSupplier } from "../controllers/supplier.controller";

const router = Router();

router.get("/", GetSuppliers);
router.get("/:id", GetSupplier);
router.post("/", AddSupplier);
router.put("/:id", UpdateSupplier);

export default router;
