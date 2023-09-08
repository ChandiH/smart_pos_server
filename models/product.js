const pool = require("../config/config");

const getProducts = () => {
  return pool.query("select * from product");
};

const getProduct = (id) => {
  return pool.query("select * from product where product_id=$1", [id]);
};

const addProduct = (product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, created_on) => {
  return pool.query(
    "INSERT INTO product (product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, created_on) VALUES  ($1, $2, $3, $4, $5 , $6,$7,$8,$9,$10,$11) returning *",
    [product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, created_on]
  );
};

const updateProduct = (id, product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity) => {
  return pool.query(
    "UPDATE product SET product_name=$1, products_desc=$2, category_ID=$3, product_image=$4, measure_of_unit_id=$5, buying_ppu=$6, retail_ppu=$7, supplier_ID=$8, barcode=$9, quantity=$10 WHERE product_id=$11 returning *",
    [product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, id]
  );  
};

module.exports = {
  getProducts,
  getProduct,
  addProduct,
  updateProduct,
};
