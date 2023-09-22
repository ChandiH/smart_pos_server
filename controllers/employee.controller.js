const Employee = require("../models/employee.model");

module.exports = {
  getEmployees(req, res, next) {
    Employee.getEmployees()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getEmployee(req, res, next) {
    const { id } = req.params;
    Employee.getEmployee(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  updateEmployee(req, res, next) {
    const { id } = req.params;
    const { employee_name, role_id, employee_email, employee_phone, branch_id} = req.body;
    Employee.updateEmployee(employee_name, role_id, employee_email, employee_phone, branch_id, id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

};
