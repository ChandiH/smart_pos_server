import type { RequestHandler } from "express";
import {
  addEmployeeRecord,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDate,
  getEmployeeRecordByDateBranch,
} from "../models/workingHour.model";

interface EmployeeRecordBody {
  employee_id: number;
  date: string;
  shift_on: string;
  shift_off: string;
  updated_by: number;
  present: boolean;
  total_hours: number;
}

export const GetEmployeeRecordByDate: RequestHandler = async (req, res) => {
  const { date } = req.params;
  return await getEmployeeRecordByDate(date)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetEmployeeRecordByBranch: RequestHandler = async (req, res) => {
  const { branch_id } = req.params;
  return await getEmployeeRecordByBranch(branch_id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetEmployeeRecordByDateBranch: RequestHandler = async (req, res) => {
  const { branch_id, date } = req.params;
  return await getEmployeeRecordByDateBranch(date, branch_id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddEmployeeRecord: RequestHandler<unknown, unknown, EmployeeRecordBody> = async (req, res) => {
  const { employee_id, date, shift_on, shift_off, updated_by, present, total_hours } = req.body;

  return await addEmployeeRecord(employee_id, date, shift_on, shift_off, updated_by, present, total_hours)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
