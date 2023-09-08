const pool = require("../config/config");

const createCart = (cashier_id) => {
        return pool.query(
          "INSERT INTO sales_history (cashier_id) VALUES ($1) RETURning *", [cashier_id]
          );
};

const addProductToCart = ( product_id, quantity) => {
  return pool.query(
    "INSERT INTO cart (transaction_number, product_id, quantity) SELECT fn_get_last_transaction_number(), $1, $2 RETURning *",
    [product_id, quantity]  );
};

const updateProductInCart = (id,  quantity) => {
  return pool.query(
    "update cart set quantity=$1 where cart_id=$2  returning *",
    [quantity, id]
  );
};

const getProductInCart = (id) => {
  return pool.query(
    "select * from cart where cart_id=$1",
    [id]
  );
};

const getCurrentCart = (id) => {
  return pool.query(
    "select * from cart where transaction_number=$1", [id]
  );
};


     
/* 
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
};*/

module.exports = {
  /*getCustomers,
  getCustomer,
  addCustomer,
  updateCustomer,*/
  createCart,
  addProductToCart,
  updateProductInCart,
  getProductInCart,
  getCurrentCart,
};
