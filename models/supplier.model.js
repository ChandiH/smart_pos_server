const pool = require("../config/config");

const getSuppliers = () => {
  return pool.query(`SELECT * FROM supplier;`);
};

const getSupplier = (id) => {
  return pool.query(`select *  from supplier where supplier_id=$1`, [id]);
};

const addSupplier = (name, email, phone, address) => {
  return pool.query(
    "INSERT INTO supplier (name, email, phone, address) values ($1, $2, $3, $4) returning *",
    [name, email, phone, address]
  );
};

module.exports = {
  getSuppliers,
  getSupplier,
  addSupplier,
};
