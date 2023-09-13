const pool = require("../config/config");

const getAllBranch = () => {
  return pool.query("select * from branch");
};

const getBranch = (id) => {
  return pool.query("select * from branch where id = $1", [id]);
};

module.exports = {
  getAllBranch,
  getBranch,
};
