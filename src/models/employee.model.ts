import { prisma } from "../config/prisma";

export const getEmployees = async () => {
  return await prisma.employee.findMany({
    include: {
      branch: {
        select: {
          branch_city: true,
        },
      },
      user_role: {
        select: {
          role_name: true,
        },
      },
    },
  });
};

export const getEmployee = async (id: number) => {
  return await prisma.employee.findUnique({
    where: { employee_id: id },
    include: {
      branch: {
        select: {
          branch_city: true,
        },
      },
      user_role: {
        select: {
          role_name: true,
          user_access: true,
        },
      },
    },
  });
};

export const getEmployeesByBranchID = async (branch_id: string) => {
  return await prisma.employee.findMany({
    where: { branch_id },
    include: {
      user_role: {
        select: {
          role_name: true,
        },
      },
    },
  });
};

export const getEmployeesByRole = async (role_id: string) => {
  return await prisma.employee.findMany({
    where: { role_id: Number(role_id) },
  });
};

export const updateEmployee = async (
  employee_name: string,
  role_id: number,
  employee_email: string,
  employee_phone: string,
  branch_id: string,
  id: string
) => {
  return await prisma.employee.update({
    where: { employee_id: Number(id) },
    data: {
      employee_name,
      role_id,
      employee_email,
      employee_phone,
      branch_id,
    },
  });
};

export const updateImage = async (employee_id: string, imageURL: string) => {
  return await prisma.employee.update({
    where: { employee_id: Number(employee_id) },
    data: {
      employee_image: imageURL,
    },
  });
};
