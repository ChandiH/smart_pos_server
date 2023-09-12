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
  addEmployee(req, res, next) {
    const { name, username, role_id, email, phone, branch_id } = req.body;
    console.log(req.body);
    Employee.addEmployee(name, username, role_id, email, phone, branch_id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  updateEmployee(req, res, next) {
    const { id } = req.params;
    const { name, username, password, role_id, email, phone, branch_id } =
      req.body;
    Employee.updateEmployee(
      id,
      name,
      username,
      password,
      role_id,
      email,
      phone,
      branch_id
    )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
