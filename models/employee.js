const pool = require("../config/config");

const getEmployees = () => {
  return pool.query(
    `select employee.*, branch.city as branch_name , user_role.role_name
    from employee 
    inner join branch on employee.branch_id = branch.id
    inner join user_role on user_role.role_id = employee.role_id`
  );
};

const getEmployee = (id) => {
  return pool.query("select * from employee where employee_ID=$1", [id]);
};

const addEmployee = (name, username, role_id, email, phone, branch_id) => {
  return pool.query(
    "INSERT INTO employee (name, username, password, role_id,  email, phone, branch_id) values ($1, $2, $3, $4, $5 , $6,$7) returning *",
    [name, username, username, role_id, email, phone, branch_id]
  );
};

const updateEmployee = (
  id,
  name,
  username,
  password,
  role_id,
  email,
  phone,
  branch_id
) => {
  return pool.query(
    "update employee set name=$1, username=$2, password=$3, role_id=$4,  email=$5, phone=$6, branch_id=$7 where employee_ID=$8 returning *",
    [name, username, password, role_id, email, phone, branch_id, id]
  );
};

module.exports = {
  getEmployees,
  getEmployee,
  addEmployee,
  updateEmployee,
};
