const UserRole = require("../models/userRole.model");
const Employee = require("../models/employee.model");

module.exports = {
  getUserRoles(req, res, next) {
    UserRole.getUserRoles()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getAccessList(req, res, next) {
    UserRole.getAccessList()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  updateUserAccess(req, res, next) {
    const { role_id, access } = req.body;
    UserRole.updateUserAccess(role_id, access)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  async addUserRole(req, res, next) {
    const { role_name, role_desc, user_access } = req.body;
    UserRole.addUserRole(role_name, role_desc, user_access)
      .then(() => res.status(200).json({ result: "successfully Added" }))
      .catch((err) => res.status(400).json({ error: err }));
  },
  async deleteUserRole(req, res, next) {
    const { id } = req.params;
    if (id == 1)
      return res.status(400).json({ error: "Owner can't be Deleted" });

    const response = await Employee.getEmployeesByRole(id);
    const employees = response.rowCount;
    if (employees)
      return res.status(400).json({
        error: `Please assign the ${employees} employees in this user role to different roles first before deleting the role.`,
      });

    UserRole.deleteUserRole(id)
      .then(() => res.status(200).json({ result: "successfully Deleted" }))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
