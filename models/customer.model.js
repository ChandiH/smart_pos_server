const pool = require("../config/config");

const getCustomers = () => {
  return pool.query("select * from customer");
};

const getCustomer = (id) => {
  return pool.query("select * from customer where customer_id=$1", [id]);
};

const addCustomer = (customer_name, customer_email, customer_phone, customer_address) => {
  return pool.query(
    `INSERT INTO customer(customer_name, customer_email, customer_phone, customer_address)
     VALUES 
      ($1, $2, $3, $4) returning *`,
    [customer_name, customer_email, customer_phone, customer_address]   
  );
};

const updateCustomer = (id, customer_name, customer_email, customer_phone, customer_address ) => {
  return pool.query(
    `UPDATE customer
    SET customer_name=$1, customer_email= $2 , customer_phone= $3, customer_address= $4
    WHERE customer_id= $5 returning *
    `,
    [customer_name, customer_email, customer_phone, customer_address , id]
  );
};



//view rewards points
//view order history of customer

module.exports = {
  getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,
};
