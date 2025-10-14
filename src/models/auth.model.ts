import type { PoolClient, QueryResult } from "pg";
import { pool } from "../config/config";

type LoginRow = {
  employee_id: number;
};

export type RegisterPayload = {
  employee_name: string;
  employee_userName: string;
  role_id: number;
  employee_email: string;
  employee_phone: string;
  branch_id: number;
  employee_image: string;
};

const login = (
  username: string,
  password: string
): Promise<QueryResult<LoginRow>> => {
  return pool.query<LoginRow>(
    "SELECT user_id as employee_id FROM  user_credentials WHERE username = $1 AND password = crypt($2, password)",
    [username, password]
  );
};

const register = async ({
  employee_name,
  employee_userName,
  role_id,
  employee_email,
  employee_phone,
  branch_id,
  employee_image,
}: RegisterPayload): Promise<boolean> => {
  const client: PoolClient = await pool.connect();
  try {
    await client.query("BEGIN");

    const employeeResult = await client.query<{ employee_id: number }>(
      "INSERT INTO employee (employee_name, role_id, employee_email, employee_phone, branch_id,employee_image) VALUES ($1, $2, $3, $4, $5,$6) RETURNING employee_id",
      [
        employee_name,
        role_id,
        employee_email,
        employee_phone,
        branch_id,
        employee_image,
      ]
    );

    const employee_id = employeeResult.rows[0]?.employee_id;

    if (!employee_id) {
      throw new Error("Failed to create employee record");
    }

    await client.query(
      "INSERT INTO user_credentials (user_id, username, password) VALUES ($1, $2, crypt($3, gen_salt('bf')))",
      [employee_id, employee_userName, employee_userName]
    );

    await client.query("COMMIT");
    return true;
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

const isUsernameTaken = async (username: string): Promise<boolean> => {
  const result = await pool.query(
    "SELECT 1 FROM user_credentials WHERE username = $1 LIMIT 1",
    [username]
  );
  return (result.rowCount ?? 0) > 0;
};

const resetPassword = async (
  username: string,
  password: string
): Promise<boolean> => {
  const result = await pool.query(
    "UPDATE user_credentials SET password = crypt($1, gen_salt('bf')) WHERE username = $2 returning *",
    [password, username]
  );
  return (result.rowCount ?? 0) > 0;
};

const checkPassword = async (
  username: string,
  password: string
): Promise<boolean> => {
  const result = await pool.query(
    "SELECT 1 FROM user_credentials WHERE username = $1 AND password = crypt($2, password) LIMIT 1",
    [username, password]
  );
  return (result.rowCount ?? 0) > 0;
};

const authModel = {
  login,
  register,
  isUsernameTaken,
  resetPassword,
  checkPassword,
};

export { login, register, isUsernameTaken, resetPassword, checkPassword };
export default authModel;
