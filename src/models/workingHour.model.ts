import prisma from "../config/prisma";

export const getEmployeeRecordByDate = async (date: string) => {
  return await prisma.employee.findMany({
    where: {
      working_hour_working_hour_employee_idToemployee: {
        some: { date: date },
      },
    },
    include: {
      user_role: true,
      working_hour_working_hour_employee_idToemployee: true,
      working_hour_working_hour_updated_byToemployee: true,
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
      working_hour_working_hour_employee_idToemployee: true,
      working_hour_working_hour_updated_byToemployee: true,
    },
  });
};

export const getEmployeeRecordByDateBranch = async (date: string, branch_id: string) => {
  return await prisma.employee.findMany({
    where: {
      branch_id: branch_id,
      working_hour_working_hour_employee_idToemployee: {
        some: { date: date },
      },
    },
    include: {
      user_role: true,
      working_hour_working_hour_employee_idToemployee: true,
      working_hour_working_hour_updated_byToemployee: true,
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
  total_hours: number
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
    },
  });
};
