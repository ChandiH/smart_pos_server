import type { RequestHandler } from "express";
import fileHandler from "../utils/fileHandler";
import {
  getEmployee,
  getEmployees,
  getEmployeesByBranchID,
  getEmployeesByRole,
  updateEmployee,
  updateImage,
} from "../models/employee.model";

interface UpdateEmployeeBody {
  employee_name: string;
  role_id: number;
  employee_email: string;
  employee_phone: string;
  branch_id: string;
}

type FileHandlerModule = {
  deleteImage: (imagePath: string) => { success: boolean; message: string };
};

const { deleteImage } = fileHandler as FileHandlerModule;

export const GetEmployees: RequestHandler = async (_req, res) => {
  return await getEmployees()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetEmployeesByBranch: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getEmployeesByBranchID(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetEmployeesByRole: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getEmployeesByRole(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetEmployee: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getEmployee(Number(id))
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateEmployee: RequestHandler<any, unknown, UpdateEmployeeBody> = async (req, res) => {
  const { id } = req.params;
  const { employee_name, role_id, employee_email, employee_phone, branch_id } = req.body;

  return await updateEmployee(employee_name, role_id, employee_email, employee_phone, branch_id, id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateEmployeeImage: RequestHandler = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await getEmployee(Number(id));

    if (result?.employee_image && result.employee_image !== "employee-image-placeholder.jpg") {
      deleteImage(`public\\image\\${result.employee_image}`);
    }

    const uploadedFile = req.file as Express.Multer.File | undefined;

    if (!uploadedFile) {
      return res.status(400).json({ error: "File upload is required" });
    }

    await updateImage(id, uploadedFile.filename);

    return res.status(200).json({
      success: "File uploaded successfully!",
      file: uploadedFile,
    });
  } catch (err) {
    console.error(err);
    return res.status(400).json({ error: err });
  }
};
