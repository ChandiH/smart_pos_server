const Employee = require("../models/employee.model");
const { deleteImage } = require("../utils/fileHandler");

module.exports = {
  getEmployees(req, res, next) {
    Employee.getEmployees()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getEmployeesByBranch(req, res, next) {
    const { id } = req.params;
    Employee.getEmployeesByBranch(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getEmployeesByRole(req, res, next) {
    const { id } = req.params;
    Employee.getEmployeesByRole(id)
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
    const {
      employee_name,
      role_id,
      employee_email,
      employee_phone,
      branch_id,
    } = req.body;
    Employee.updateEmployee(
      employee_name,
      role_id,
      employee_email,
      employee_phone,
      branch_id,
      id
    )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  async updateEmployeeImage(req, res, next) {
    const { id } = req.params;
    const result = await Employee.getEmployee(id);
    const employee = result.rows[0];
    //remove previous photo
    deleteImage("public\\image\\" + employee.employee_image);

    await Employee.updateImage(id, req.file.filename)
      .then(() =>
        res
          .status(200)
          .json({ message: "File uploaded successfully!", file: req.file })
      )
      .catch((err) => res.status(400).json({ error: err }));
  },
};
