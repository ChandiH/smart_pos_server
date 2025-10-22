import prisma from "../config/prisma";

export const getEmployeeRecordByDate = async (date: string) => {
  return await prisma.employee.findMany({
    where: {
      working_hour: {
        some: { date: date },
      },
    },
    include: {
      user_role: true,
      working_hour: true,
    },
  });
};

export const getEmployeeRecordByBranch = async (branch_id: string) => {
  return await prisma.employee.findMany({
    where: {
      branch_id: branch_id,
    },
    include: {
      user_role: true,
      working_hour: true,
    },
  });
};

export const getEmployeeRecordByDateBranch = async (date: string, branch_id: string) => {
  return await prisma.working_hour.findMany({
    where: {
      branch_id,
      date: date,
    },
    include: {
      employee: true,
    },
  });
};

export const addEmployeeRecord = async (
  employee_id: number,
  date: string,
  shift_on: string,
  shift_off: string,
  updated_by: number,
  present: boolean,
  total_hours: number,
  branch_id: string
) => {
  return await prisma.working_hour.create({
    data: {
      employee_id,
      date,
      shift_on,
      shift_off,
      updated_by,
      present,
      total_hours,
      branch_id,
    },
  });
};
