import type { QueryResult } from "pg";
import { pool } from "../config/config";

type WorkingHourRow = Record<string, unknown>;

const getEmployeeRecordByDate = (
  date: string
): Promise<QueryResult<WorkingHourRow>> => {
  return pool.query<WorkingHourRow>(
    `select working_hour.*, employee.employee_name, user_role.role_name from working_hour 
    inner join employee on employee.employee_id = working_hour.employee_id 
    inner join user_role on user_role.role_id = employee.role_id
    where date=$1`,
    [date]
  );
};

const getEmployeeRecordByBranch = (
  branch_id: string
): Promise<QueryResult<WorkingHourRow>> => {
  return pool.query<WorkingHourRow>(
    `select working_hour.*, employee.employee_name, user_role.role_name from working_hour 
    inner join employee on employee.employee_id = working_hour.employee_id
    inner join user_role on user_role.role_id = employee.role_id 
    where employee.branch_id=$1`,
    [branch_id]
  );
};

const getEmployeeRecordByDateBranch = (
  date: string,
  branch_id: string
): Promise<QueryResult<WorkingHourRow>> => {
  return pool.query<WorkingHourRow>(
    `select working_hour.*, employee.employee_name, user_role.role_name from working_hour 
    inner join employee on employee.employee_id = working_hour.employee_id
    inner join user_role on user_role.role_id = employee.role_id 
    where employee.branch_id=$1 and working_hour.date=$2`,
    [branch_id, date]
  );
};

const addEmployeeRecord = (
  employee_id: number,
  date: string,
  shift_on: string,
  shift_off: string,
  updated_by: number,
  present: boolean,
  total_hours: number
): Promise<QueryResult<WorkingHourRow>> => {
  return pool.query<WorkingHourRow>(
    `INSERT INTO working_hour (employee_id, date, shift_on, shift_off, updated_by, present, total_hours)
    VALUES ($1, $2, $3, $4, $5, $6, $7) returning *`,
    [employee_id, date, shift_on, shift_off, updated_by, present, total_hours]
  );
};

const workingHourModel = {
  getEmployeeRecordByDate,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDateBranch,
  addEmployeeRecord,
};

export {
  getEmployeeRecordByDate,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDateBranch,
  addEmployeeRecord,
};
export default workingHourModel;
