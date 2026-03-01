import type { RequestHandler } from "express";
import { addCustomer, getCustomer, getCustomers, updateCustomer } from "../models/customer.model";

interface CustomerBody {
  customer_name: string;
  customer_email: string;
  customer_phone: string;
  customer_address: string;
}

export const GetCustomers: RequestHandler = async (_req, res) => {
  return getCustomers()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetCustomerByID: RequestHandler = async (req, res) => {
  const { id } = req.params;

  return getCustomer(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddCustomer: RequestHandler<unknown, unknown, CustomerBody> = async (req, res) => {
  const { customer_name, customer_email, customer_phone, customer_address } = req.body;
  return addCustomer(customer_name, customer_email, customer_phone, customer_address)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateCustomer: RequestHandler<any, unknown, CustomerBody> = async (req, res) => {
  const { id } = req.params;
  const { customer_name, customer_email, customer_phone, customer_address } = req.body;

  return updateCustomer(id, customer_name, customer_email, customer_phone, customer_address)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
