import type { QueryResult } from "pg";
import { pool } from "../config/config";

type SupplierRow = Record<string, unknown>;

const getSuppliers = (): Promise<QueryResult<SupplierRow>> => {
  return pool.query<SupplierRow>(`SELECT * FROM supplier;`);
};

const getSupplier = (id: string): Promise<QueryResult<SupplierRow>> => {
  return pool.query<SupplierRow>(
    `select *  from supplier where supplier_id=$1`,
    [id]
  );
};

const addSupplier = (
  name: string,
  email: string,
  phone: string,
  address: string
): Promise<QueryResult<SupplierRow>> => {
  return pool.query<SupplierRow>(
    "INSERT INTO supplier (supplier_name, supplier_email, supplier_phone, supplier_address) values ($1, $2, $3, $4) returning *",
    [name, email, phone, address]
  );
};

const isEmailTaken = async (email: string): Promise<number> => {
  const result = await pool.query(
    "SELECT 1 FROM supplier where supplier_email=$1 LIMIT 1",
    [email]
  );
  return result.rowCount ?? 0;
};

const isPhoneNumberExist = async (phone: string): Promise<number> => {
  const result = await pool.query(
    "SELECT 1 FROM supplier where supplier_phone=$1 LIMIT 1",
    [phone]
  );
  return result.rowCount ?? 0;
};

const supplierModel = {
  getSuppliers,
  getSupplier,
  addSupplier,
  isEmailTaken,
  isPhoneNumberExist,
};

export {
  getSuppliers,
  getSupplier,
  addSupplier,
  isEmailTaken,
  isPhoneNumberExist,
};
export default supplierModel;
