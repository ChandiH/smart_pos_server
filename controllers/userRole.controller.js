const UserRole = require("../models/userRole.model");

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
};
