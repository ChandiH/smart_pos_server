import { Router, type RequestHandler } from "express";
import supplierController from "../controllers/supplier.controller";

type SupplierController = {
  getSuppliers: RequestHandler;
  getSupplier: RequestHandler;
  addSupplier: RequestHandler;
};

const { getSuppliers, getSupplier, addSupplier } =
  supplierController as SupplierController;

const router = Router();

router.get("/", getSuppliers);
router.get("/:id", getSupplier);
router.post("/", addSupplier);

export default router;
