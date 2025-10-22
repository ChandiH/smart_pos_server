import { Router } from "express";
import { AddCustomer, GetCustomerByID, GetCustomers, UpdateCustomer } from "../controllers/customer.controller";

const router = Router();

router.get("/", GetCustomers);
router.get("/:id", GetCustomerByID);
router.post("/", AddCustomer);
router.put("/:id", UpdateCustomer);

export default router;
