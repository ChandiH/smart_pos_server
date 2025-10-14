import type { RequestHandler } from "express";
import Employee from "../models/employee.model";
import fileHandler from "../utils/fileHandler";

type EmployeeModel = {
  getEmployees: () => Promise<{ rows: unknown[] }>;
  getEmployeesByBranch: (branchId: string) => Promise<{ rows: unknown[] }>;
  getEmployeesByRole: (roleId: string) => Promise<{ rows: unknown[] }>;
  getEmployee: (id: string) => Promise<{ rows: Array<Record<string, unknown>> }>;
  updateEmployee: (
    employeeName: string,
    roleId: number,
    employeeEmail: string,
    employeePhone: string,
    branchId: number,
    id: string
  ) => Promise<{ rows: unknown[] }>;
  updateImage: (id: string, imageUrl: string) => Promise<unknown>;
};

type FileHandlerModule = {
  deleteImage: (imagePath: string) => { success: boolean; message: string };
};

const employeeModel = Employee as EmployeeModel;
const { deleteImage } = fileHandler as FileHandlerModule;

const getEmployees: RequestHandler = (_req, res) => {
  return employeeModel
    .getEmployees()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getEmployeesByBranch: RequestHandler = (req, res) => {
  const { id } = req.params;
  return employeeModel
    .getEmployeesByBranch(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getEmployeesByRole: RequestHandler = (req, res) => {
  const { id } = req.params;
  return employeeModel
    .getEmployeesByRole(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getEmployee: RequestHandler = (req, res) => {
  const { id } = req.params;
  return employeeModel
    .getEmployee(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface UpdateEmployeeBody {
  employee_name: string;
  role_id: number;
  employee_email: string;
  employee_phone: string;
  branch_id: number;
}

const updateEmployee: RequestHandler<unknown, unknown, UpdateEmployeeBody> = (
  req,
  res
) => {
  const { id } = req.params;
  const {
    employee_name,
    role_id,
    employee_email,
    employee_phone,
    branch_id,
  } = req.body;

  return employeeModel
    .updateEmployee(
      employee_name,
      role_id,
      employee_email,
      employee_phone,
      branch_id,
      id
    )
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const updateEmployeeImage: RequestHandler = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await employeeModel.getEmployee(id);
    const employee = result.rows[0] as { employee_image?: string } | undefined;

    if (employee?.employee_image && employee.employee_image !== "employee-image-placeholder.jpg") {
      deleteImage(`public\\image\\${employee.employee_image}`);
    }

    const uploadedFile = req.file as Express.Multer.File | undefined;

    if (!uploadedFile) {
      return res.status(400).json({ error: "File upload is required" });
    }

    await employeeModel.updateImage(id, uploadedFile.filename);

    return res.status(200).json({
      success: "File uploaded successfully!",
      file: uploadedFile,
    });
  } catch (err) {
    console.error(err);
    return res.status(400).json({ error: err });
  }
};

export default {
  getEmployees,
  getEmployeesByBranch,
  getEmployeesByRole,
  getEmployee,
  updateEmployee,
  updateEmployeeImage,
};
