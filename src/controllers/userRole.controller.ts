import type { RequestHandler } from "express";
import UserRole from "../models/userRole.model";
import Employee from "../models/employee.model";

type UserRoleModel = {
  getUserRoles: () => Promise<{ rows: unknown[] }>;
  getAccessList: () => Promise<{ rows: unknown[] }>;
  updateUserAccess: (roleId: number, access: unknown) => Promise<{ rows: unknown[] }>;
  addUserRole: (roleName: string, roleDesc: string, userAccess: unknown) => Promise<unknown>;
  deleteUserRole: (id: string) => Promise<unknown>;
};

type EmployeeModel = {
  getEmployeesByRole: (
    roleId: string
  ) => Promise<{ rowCount: number }>;
};

const userRoleModel = UserRole as UserRoleModel;
const employeeModel = Employee as EmployeeModel;

const getUserRoles: RequestHandler = (_req, res) => {
  return userRoleModel
    .getUserRoles()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getAccessList: RequestHandler = (_req, res) => {
  return userRoleModel
    .getAccessList()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface UpdateUserAccessBody {
  role_id: number;
  access: unknown;
}

const updateUserAccess: RequestHandler<
  unknown,
  unknown,
  UpdateUserAccessBody
> = (req, res) => {
  const { role_id, access } = req.body;
  return userRoleModel
    .updateUserAccess(role_id, access)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface AddUserRoleBody {
  role_name: string;
  role_desc: string;
  user_access: unknown;
}

const addUserRole: RequestHandler<unknown, unknown, AddUserRoleBody> = (
  req,
  res
) => {
  const { role_name, role_desc, user_access } = req.body;
  return userRoleModel
    .addUserRole(role_name, role_desc, user_access)
    .then(() => res.status(200).json({ result: "successfully Added" }))
    .catch((err) => res.status(400).json({ error: err }));
};

const deleteUserRole: RequestHandler = async (req, res) => {
  const { id } = req.params;

  if (id === "1") {
    return res.status(400).json({ error: "Owner can't be Deleted" });
  }

  try {
    const response = await employeeModel.getEmployeesByRole(id);
    const employees = response.rowCount;

    if (employees) {
      return res.status(400).json({
        error: `Please assign the ${employees} employees in this user role to different roles first before deleting the role.`,
      });
    }

    return userRoleModel
      .deleteUserRole(id)
      .then(() => res.status(200).json({ result: "successfully Deleted" }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};

export default {
  getUserRoles,
  getAccessList,
  updateUserAccess,
  addUserRole,
  deleteUserRole,
};
