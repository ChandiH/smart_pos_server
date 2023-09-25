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
  async checkAccess(req, res, next) {
    const { role_id, access_name } = req.body;
    console.log(req.body);
    try {
      const userRole = await UserRole.getUserRole(role_id);
      const userAccess = userRole.rows[0].user_access;

      const access = await UserRole.getAccessEnum(access_name);
      const access_id = access.rows[0].access_type_id;

      if (userAccess.includes(access_id)) {
        return res.status(200).json({ access: true });
      } else {
        return res.status(200).json({ access: false });
      }
    } catch (e) {
      return res.status(400).json({ error: "error ocured" });
    }
  },
};
