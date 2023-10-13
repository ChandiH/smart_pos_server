const pool = require("../config/config");

const getEmployeeRecordByDate = (date) => {
  return pool.query(
    `select working_hour.*, employee.employee_name, user_role.role_name from working_hour 
    inner join employee on employee.employee_id = working_hour.employee_id 
    inner join user_role on user_role.role_id = employee.role_id
    where date=$1`,
    [date]
  );
};

const getEmployeeRecordByBranch = (branch_id) => {
  return pool.query(
    `select working_hour.*, employee.employee_name, user_role.role_name from working_hour 
    inner join employee on employee.employee_id = working_hour.employee_id
    inner join user_role on user_role.role_id = employee.role_id 
    where employee.branch_id=$1`,
    [branch_id]
  );
};

const getEmployeeRecordByDateBranch = (date, branch_id) => {
  return pool.query(
    `select working_hour.*, employee.employee_name, user_role.role_name from working_hour 
    inner join employee on employee.employee_id = working_hour.employee_id
    inner join user_role on user_role.role_id = employee.role_id 
    where employee.branch_id=$1 and working_hour.date=$2`,
    [branch_id, date]
  );
};

const addEmployeeRecord = (
  employee_id,
  date,
  shift_on,
  shift_off,
  updated_by,
  present,
  total_hours
) => {
  return pool.query(
    `INSERT INTO working_hour (employee_id, date, shift_on, shift_off, updated_by, present, total_hours)
    VALUES ($1, $2, $3, $4, $5, $6, $7) returning *`,
    [employee_id, date, shift_on, shift_off, updated_by, present, total_hours]
  );
};

module.exports = {
  getEmployeeRecordByDate,
  getEmployeeRecordByBranch,
  getEmployeeRecordByDateBranch,
  addEmployeeRecord,
};
