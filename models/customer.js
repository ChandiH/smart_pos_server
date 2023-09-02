const pool = require("../config/config");

const getCustomers = () => {
  return pool.query("select * from customer");
};

const getCustomer = (id) => {
  return pool.query("select * from customer where customer_id=$1", [id]);
};

const addCustomer = (name, contact) => {
  return pool.query(
    "insert into Customer ( name, contact, visitCount, totalSpent, pointCount) values ($1, $2, $3, $4, $5) returning *",
    [name, contact, 0, 0, 0]
  );
};

module.exports = {
  getCustomers,
  getCustomer,
  addCustomer,
};
