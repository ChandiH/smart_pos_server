const pool = require("../config/config");

const getUserRoles = () => {
  return pool.query("select * from user_role");
};

const getUserRole = (role_id) => {
  return pool.query("select * from user_role where role_id = $1", [role_id]);
};

const getAccessList = () => {
  return pool.query("select * from access_type");
};

const getAccessEnum = (access_name) => {
  return pool.query("select * from access_type where access_name = $1", [
    access_name,
  ]);
};

const updateUserAccess = (role_id, access) => {
  return pool.query(
    "update user_role set user_access = $1 where role_id = $2",
    [access, role_id]
  );
};

module.exports = {
  getUserRoles,
  getUserRole,
  getAccessList,
  getAccessEnum,
  updateUserAccess,
};
