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

const paymentCompleted = (id) => {
  return pool.query(
    " update sales_history set status='paid' where transaction_number = (SELECT fn_get_last_transaction_number())"
  );
};



module.exports = {
  createCart,
  addProductToCart,
  updateProductInCart,
  getProductInCart,
  getCurrentCart,
  paymentCompleted,
};
