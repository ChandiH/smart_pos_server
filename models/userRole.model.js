const pool = require("../config/config");

const getUserRoles = () => {
  return pool.query("select * from user_role");
};

const getAccessList = () => {
  return pool.query("select * from access_type");
};

const updateUserAccess = (role_id, access) => {
  return pool.query(
    "update user_role set user_access = $1 where role_id = $2",
    [access, role_id]
  );
};

module.exports = {
  getUserRoles,
  getAccessList,
  updateUserAccess,
};
