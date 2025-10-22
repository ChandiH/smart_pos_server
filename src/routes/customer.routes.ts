import { Router, type RequestHandler } from "express";
import customerController from "../controllers/customer.controller";

type CustomerController = {
  getCustomers: RequestHandler;
  getCustomer: RequestHandler;
  addCustomer: RequestHandler;
  updateCustomer: RequestHandler;
};

const { getCustomers, getCustomer, addCustomer, updateCustomer } =
  customerController as CustomerController;

const router = Router();

router.get("/", getCustomers);
router.get("/:id", getCustomer);
router.post("/", addCustomer);
router.put("/:id", updateCustomer);

export default router;
