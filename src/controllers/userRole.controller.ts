import type { RequestHandler } from "express";
import { addUserRole, deleteUserRole, getAccessList, getUserRoles, updateUserAccess } from "../models/userRole.model";
import { getEmployeesByRole } from "../models/employee.model";

interface UpdateUserAccessBody {
  role_id: number;
  access: number[];
}

interface AddUserRoleBody {
  role_name: string;
  role_desc: string;
  user_access: number[];
}

export const GetUserRoles: RequestHandler = async (_req, res) => {
  return await getUserRoles()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetAccessList: RequestHandler = async (_req, res) => {
  return await getAccessList()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateUserAccess: RequestHandler<unknown, unknown, UpdateUserAccessBody> = async (req, res) => {
  const { role_id, access } = req.body;
  return await updateUserAccess(role_id, access)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddUserRole: RequestHandler<unknown, unknown, AddUserRoleBody> = async (req, res) => {
  const { role_name, role_desc, user_access } = req.body;
  return await addUserRole(role_name, role_desc, user_access)
    .then(() => res.status(200).json({ result: "successfully Added" }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const DeleteUserRole: RequestHandler = async (req, res) => {
  const { id } = req.params;

  if (id === "1") {
    return res.status(400).json({ error: "Owner can't be Deleted" });
  }

  try {
    const response = await getEmployeesByRole(id);
    const employees = response.length;

    if (employees) {
      return res.status(400).json({
        error: `Please assign the ${employees} employees in this user role to different roles first before deleting the role.`,
      });
    }

    return deleteUserRole(id)
      .then(() => res.status(200).json({ result: "successfully Deleted" }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};
