const pool = require("../config/config");

const getCustomers = () => {
  return pool.query("select * from customer");
};

const getCustomer = (id) => {
  return pool.query("select * from customer where customer_id=$1", [id]);
};

const addCustomer = (name, email, phone, address) => {
  return pool.query(
    "insert into  customer (name, email, phone, address, visit_count, rewards_points) values ($1, $2, $3, $4, $5 , $6) returning *",
    [name, email, phone, address, 0, 0]
  );
};

const updateCustomer = (id, name, email, phone, address) => {
  return pool.query(
    "update customer set name=$1, email=$2, phone=$3, address=$4 where customer_id=$5 returning *",
    [name, email, phone, address, id]
  );
};

module.exports = {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
};
