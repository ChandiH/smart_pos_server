import type { RequestHandler } from "express";
import {
  addSupplier,
  getSupplier,
  getSuppliers,
  isEmailTaken,
  isPhoneNumberExist,
  updateSupplier,
} from "../models/supplier.model";
import { supplier } from "../prisma";

type SupplierBody = Omit<supplier, "supplier_id">;

export const GetSuppliers: RequestHandler = async (_req, res) => {
  return await getSuppliers()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetSupplier: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getSupplier(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddSupplier: RequestHandler<unknown, unknown, SupplierBody> = async (req, res) => {
  const { supplier_name, supplier_email, supplier_phone, supplier_address } = req.body;
  console.log(req.body);

  try {
    const email = supplier_email ? await isEmailTaken(supplier_email) : 0;
    if (email > 0) {
      return res.status(400).json({ error: { supplier_email: "Email already exists" } });
    }

    const phone = await isPhoneNumberExist(supplier_phone);
    if (phone > 0) {
      return res.status(400).json({ error: { supplier_phone: "PhoneNumber already exists" } });
    }

    return await addSupplier({ supplier_name, supplier_email, supplier_phone, supplier_address })
      .then((data) => res.status(200).json({ data }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};

export const UpdateSupplier: RequestHandler = async (req, res) => {
  const { supplier_name, supplier_email, supplier_phone, supplier_address } = req.body;
  const { id } = req.params;
  console.log(id, req.body);

  try {
    return await updateSupplier(Number(id), { supplier_name, supplier_email, supplier_phone, supplier_address })
      .then((data) => res.status(200).json({ data }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};
