import type { QueryResult } from "pg";
import { pool } from "../config/config";

type UserRoleRow = Record<string, unknown>;
type AccessRow = Record<string, unknown>;

const getUserRoles = (): Promise<QueryResult<UserRoleRow>> => {
  return pool.query<UserRoleRow>("select * from user_role");
};

const getUserRole = (role_id: string): Promise<QueryResult<UserRoleRow>> => {
  return pool.query<UserRoleRow>(
    "select * from user_role where role_id = $1",
    [role_id]
  );
};

const getAccessList = (): Promise<QueryResult<AccessRow>> => {
  return pool.query<AccessRow>("select * from access_type");
};

const getAccessEnum = (
  access_name: string
): Promise<QueryResult<AccessRow>> => {
  return pool.query<AccessRow>(
    "select * from access_type where access_name = $1",
    [access_name]
  );
};

const updateUserAccess = (
  role_id: number,
  access: unknown
): Promise<QueryResult<UserRoleRow>> => {
  return pool.query<UserRoleRow>(
    "update user_role set user_access = $1 where role_id = $2",
    [access, role_id]
  );
};

const addUserRole = (
  role_name: string,
  role_desc: string,
  user_access: unknown
): Promise<QueryResult<UserRoleRow>> => {
  return pool.query<UserRoleRow>(
    "insert into user_role (role_name, role_desc, user_access) values ($1, $2, $3)",
    [role_name, role_desc, user_access]
  );
};

const deleteUserRole = (
  role_id: string
): Promise<QueryResult<UserRoleRow>> => {
  return pool.query<UserRoleRow>(
    "DELETE FROM public.user_role WHERE role_id=$1",
    [role_id]
  );
};

const userRoleModel = {
  getUserRoles,
  getUserRole,
  getAccessList,
  getAccessEnum,
  updateUserAccess,
  addUserRole,
  deleteUserRole,
};

export {
  getUserRoles,
  getUserRole,
  getAccessList,
  getAccessEnum,
  updateUserAccess,
  addUserRole,
  deleteUserRole,
};
export default userRoleModel;
