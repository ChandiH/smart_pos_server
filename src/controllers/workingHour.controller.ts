import type { RequestHandler } from "express";
import Record from "../models/workingHour.model";

type WorkingHourModel = {
  getEmployeeRecordByDate: (date: string) => Promise<{ rows: unknown[] }>;
  getEmployeeRecordByBranch: (
    branchId: string
  ) => Promise<{ rows: unknown[] }>;
  getEmployeeRecordByDateBranch: (
    date: string,
    branchId: string
  ) => Promise<{ rows: unknown[] }>;
  addEmployeeRecord: (
    employeeId: number,
    date: string,
    shiftOn: string,
    shiftOff: string,
    updatedBy: number,
    present: boolean,
    totalHours: number
  ) => Promise<{ rows: unknown[] }>;
};

const workingHourModel = Record as WorkingHourModel;

const getEmployeeRecordByDate: RequestHandler = (req, res) => {
  const { date } = req.params;
  return workingHourModel
    .getEmployeeRecordByDate(date)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getEmployeeRecordByBranch: RequestHandler = (req, res) => {
  const { branch_id } = req.params;
  return workingHourModel
    .getEmployeeRecordByBranch(branch_id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getEmployeeRecordByDateBranch: RequestHandler = (req, res) => {
  const { branch_id, date } = req.params;
  return workingHourModel
    .getEmployeeRecordByDateBranch(date, branch_id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface EmployeeRecordBody {
  employee_id: number;
  date: string;
  shift_on: string;
  shift_off: string;
  updated_by: number;
  present: boolean;
  total_hours: number;
}

const addEmployeeRecord: RequestHandler<unknown, unknown, EmployeeRecordBody> = (
  req,
  res
) => {
  const {
    employee_id,
    date,
    shift_on,
    shift_off,
    updated_by,
    present,
    total_hours,
  } = req.body;

  return workingHourModel
    .addEmployeeRecord(
      employee_id,
      date,
      shift_on,
      shift_off,
      updated_by,
      present,
      total_hours
    )
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

export default {
  getEmployeeRecordByDate,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDateBranch,
  addEmployeeRecord,
};
