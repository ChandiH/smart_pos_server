import type { QueryResult } from "pg";
import { pool } from "../config/config";

type CustomerRow = Record<string, unknown>;

const getCustomers = (): Promise<QueryResult<CustomerRow>> => {
  return pool.query<CustomerRow>("select * from customer");
};

const getCustomer = (id: string): Promise<QueryResult<CustomerRow>> => {
  return pool.query<CustomerRow>(
    "select * from customer where customer_id=$1",
    [id]
  );
};

const addCustomer = (
  customer_name: string,
  customer_email: string,
  customer_phone: string,
  customer_address: string
): Promise<QueryResult<CustomerRow>> => {
  return pool.query<CustomerRow>(
    `INSERT INTO customer(customer_name, customer_email, customer_phone, customer_address)
     VALUES 
      ($1, $2, $3, $4) returning *`,
    [customer_name, customer_email, customer_phone, customer_address]
  );
};

const updateCustomer = (
  id: string,
  customer_name: string,
  customer_email: string,
  customer_phone: string,
  customer_address: string
): Promise<QueryResult<CustomerRow>> => {
  return pool.query<CustomerRow>(
    `UPDATE customer
    SET customer_name=$1, customer_email= $2 , customer_phone= $3, customer_address= $4
    WHERE customer_id= $5 returning *
    `,
    [customer_name, customer_email, customer_phone, customer_address, id]
  );
};

const findEmail = async (email: string): Promise<number> => {
  const result = await pool.query(
    "SELECT 1 FROM customer where customer_email=$1 LIMIT 1",
    [email]
  );
  return result.rowCount ?? 0;
};

const findPhone = async (phone: string): Promise<number> => {
  const result = await pool.query(
    "SELECT 1 FROM customer where customer_phone=$1 LIMIT 1",
    [phone]
  );
  return result.rowCount ?? 0;
};

const customerModel = {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
  findPhone,
  findEmail,
};

export {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
  findPhone,
  findEmail,
};
export default customerModel;
