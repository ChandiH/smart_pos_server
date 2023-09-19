const pool = require("../config/config");

const getSuppliers = () => {
  return pool.query(`SELECT * FROM supplier;`);
};

const getSupplier = (id) => {
  return pool.query(`select *  from supplier where supplier_id=$1`, [id]);
};

const addSupplier = (name, email, phone, address) => {
  return pool.query(
    "INSERT INTO supplier (supplier_name, supplier_email, supplier_phone, supplier_address) values ($1, $2, $3, $4) returning *",
    [name, email, phone, address]
  );
};

const isEmailTaken = async (email) => {
  const result = await pool.query(
    "SELECT 1 FROM supplier where supplier_email=$1 LIMIT 1",
    [email]
  );
  return result.rowCount > 0;
};

module.exports = {
  getSuppliers,
  getSupplier,
  addSupplier,
  isEmailTaken,
};
