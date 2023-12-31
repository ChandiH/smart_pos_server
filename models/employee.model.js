const pool = require("../config/config");

//employee image

const getEmployees = () => {
  return pool.query(
    `select employee.*, branch.branch_city as branch_name , user_role.role_name 
    from employee inner join branch 
            on employee.branch_id = branch.branch_id 
                  inner join user_role on 
                      user_role.role_id = employee.role_id
      `
  );
};

const getEmployee = (id) => {
  return pool.query(
    `select employee.*, branch.branch_city as branch_name
    from employee
    inner join branch on employee.branch_id = branch.branch_id
    where employee.employee_id = $1
    `,
    [id]
  );
};

const getEmployeesByBranch = (id) => {
  return pool.query(
    `select employee.*, user_role.role_name
    from employee
    inner join user_role on employee.role_id = user_role.role_id
    where employee.branch_id=$1`,
    [id]
  );
};

const getEmployeesByRole = (id) => {
  return pool.query(`select * from employee where role_id=$1`, [id]);
};

const getUserEmployee = (id) => {
  return pool.query(
    `select employee.*, branch.branch_city as branch_name, user_role.role_name, user_role.user_access
    from employee
    inner join branch on employee.branch_id = branch.branch_id
    inner join user_role on user_role.role_id = employee.role_id
    where employee.employee_id = $1
    `,
    [id]
  );
};

const updateEmployee = (
  employee_name,
  branch_id,
  employee_email,
  employee_phone,
  role_id,
  id
) => {
  return pool.query(
    `update employee 
    set employee_name= $1, role_id= $2, employee_email= $3, employee_phone= $4,
     branch_id= $5
    where employee_id= $6 returning *`,
    [employee_name, branch_id, employee_email, employee_phone, role_id, id]
  );
};

const updateImage = (employee_id, imageURL) => {
  return pool.query(
    `update employee 
  set employee_image= $2
  where employee_id= $1`,
    [employee_id, imageURL]
  );
};

module.exports = {
  getEmployees,
  getEmployee,
  getEmployeesByBranch,
  getEmployeesByRole,
  updateEmployee,
  getUserEmployee,
  updateImage,
};
