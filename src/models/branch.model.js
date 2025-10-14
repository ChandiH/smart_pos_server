import { pool } from "../config/config";

const getBranches = () => {
  return pool.query("select * from branch");
};

const getBranch = (id) => {
  return pool.query("select * from branch where branch_id = $1", [id]);
};

const addBranch = (branch_city, branch_address, branch_phone, branch_email) => {
  return pool.query(
    `INSERT INTO branch(
      branch_city, branch_address, branch_phone, branch_email)
      VALUES ($1, $2, $3, $4) returning *`,
    [branch_city, branch_address, branch_phone, branch_email]
  );
};

const updateBranch = (
  id,
  branch_city,
  branch_address,
  branch_phone,
  branch_email
) => {
  return pool.query(
    "update branch set branch_city=$1, branch_address=$2, branch_phone=$3, branch_email=$4 where branch_id=$5 returning *",
    [branch_city, branch_address, branch_phone, branch_email, id]
  );
};

module.exports = {
  getBranches,
  getBranch,
  addBranch,
  updateBranch,
};
