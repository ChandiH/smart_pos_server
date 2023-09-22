const pool = require("../config/config");

const getSuppliers = () => {
  return pool.query(`SELECT * FROM supplier`);
};

const getSupplier = (id) => {
  return pool.query(`select *  from supplier where supplier_id=$1`, [id]);
};

const addSupplier = (supplier_name  ,supplier_email ,supplier_phone ,supplier_address) => {
  return pool.query(
    "INSERT INTO supplier (supplier_name  ,supplier_email ,supplier_phone ,supplier_address ) values ($1, $2, $3, $4) returning *",
    [supplier_name  ,supplier_email ,supplier_phone ,supplier_address]
  );
};

module.exports = {
  getSuppliers,
  getSupplier,
  addSupplier,
};
