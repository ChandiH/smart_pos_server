import type { RequestHandler } from "express";
import Customer from "../models/customer.model";

type CustomerModel = {
  getCustomers: () => Promise<{ rows: unknown[] }>;
  getCustomer: (id: string) => Promise<{ rows: unknown[] }>;
  addCustomer: (
    name: string,
    email: string,
    phone: string,
    address: string
  ) => Promise<{ rows: unknown[] }>;
  findPhone: (phone: string) => Promise<number>;
  findEmail: (email: string) => Promise<number>;
  updateCustomer: (
    id: string,
    name: string,
    email: string,
    phone: string,
    address: string
  ) => Promise<{ rows: unknown[] }>;
};

const customerModel = Customer as CustomerModel;

const getCustomers: RequestHandler = (_req, res) => {
  return customerModel
    .getCustomers()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getCustomer: RequestHandler = (req, res) => {
  const { id } = req.params;
  console.log(req.headers);

  return customerModel
    .getCustomer(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface CustomerBody {
  customer_name: string;
  customer_email: string;
  customer_phone: string;
  customer_address: string;
}

const addCustomer: RequestHandler<unknown, unknown, CustomerBody> = async (
  req,
  res
) => {
  const { customer_name, customer_email, customer_phone, customer_address } =
    req.body;

  try {
    const phone = await customerModel.findPhone(customer_phone);
    if (phone > 0) {
      return res
        .status(400)
        .json({ error: { customer_phone: "Phone already exists" } });
    }

    const email = await customerModel.findEmail(customer_email);
    if (email > 0) {
      return res
        .status(400)
        .json({ error: { customer_email: "Email already exists" } });
    }

    return customerModel
      .addCustomer(
        customer_name,
        customer_email,
        customer_phone,
        customer_address
      )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};

const updateCustomer: RequestHandler<unknown, unknown, CustomerBody> = (
  req,
  res
) => {
  const { id } = req.params;
  const { customer_name, customer_email, customer_phone, customer_address } =
    req.body;

  return customerModel
    .updateCustomer(
      id,
      customer_name,
      customer_email,
      customer_phone,
      customer_address
    )
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

export default {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
};
