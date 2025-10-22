import type { RequestHandler } from "express";
import Supplier from "../models/supplier.model";

type SupplierModel = {
  getSuppliers: () => Promise<{ rows: unknown[] }>;
  getSupplier: (id: string) => Promise<{ rows: unknown[] }>;
  isEmailTaken: (email: string) => Promise<number>;
  isPhoneNumberExist: (phone: string) => Promise<number>;
  addSupplier: (
    name: string,
    email: string,
    phone: string,
    address: string
  ) => Promise<{ rows: unknown[] }>;
};

const supplierModel = Supplier as SupplierModel;

const getSuppliers: RequestHandler = (_req, res) => {
  return supplierModel
    .getSuppliers()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getSupplier: RequestHandler = (req, res) => {
  const { id } = req.params;
  return supplierModel
    .getSupplier(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface SupplierBody {
  supplier_name: string;
  supplier_email: string;
  supplier_phone: string;
  supplier_address: string;
}

const addSupplier: RequestHandler<unknown, unknown, SupplierBody> = async (
  req,
  res
) => {
  const { supplier_name, supplier_email, supplier_phone, supplier_address } =
    req.body;
  console.log(req.body);

  try {
    const email = await supplierModel.isEmailTaken(supplier_email);
    if (email > 0) {
      return res
        .status(400)
        .json({ error: { supplier_email: "Email already exists" } });
    }

    const phone = await supplierModel.isPhoneNumberExist(supplier_phone);
    if (phone > 0) {
      return res
        .status(400)
        .json({ error: { supplier_phone: "PhoneNumber already exists" } });
    }

    return supplierModel
      .addSupplier(
        supplier_name,
        supplier_email,
        supplier_phone,
        supplier_address
      )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};

export default {
  getSuppliers,
  getSupplier,
  addSupplier,
};
