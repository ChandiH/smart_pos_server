const pool = require("../config/config");

const getProducts = () => {
  return pool.query(
    "select product.*, category.name as category_name from product inner join category on product.category_id = category.category_id"
  );
};

const getProduct = (id) => {
  return pool.query("select * from product where product_id=$1", [id]);
};

const addProduct = (
  name,
  description,
  category_id,
  product_image,
  buying_ppu,
  retail_ppu,
  discount,
  supplier_id,
  barcode
) => {
  return pool.query(
    "INSERT INTO product (name, description, category_ID, product_image, buying_ppu, retail_ppu, supplier_ID, barcode, discount) VALUES  ($1, $2, $3, $4, $5 , $6,$7,$8,$9) returning *",
    [
      name,
      description,
      category_id,
      null,
      buying_ppu,
      retail_ppu,
      supplier_id,
      barcode,
      discount,
    ]
  );
};

const updateProduct = (
  id,
  name,
  description,
  category_id,
  product_image,
  unit_id,
  buying_ppu,
  retail_ppu,
  supplier_id,
  barcode,
  quantity
) => {
  return pool.query(
    "UPDATE product SET name=$1, description=$2, category_ID=$3, product_image=$4, unit_id=$5, buying_ppu=$6, retail_ppu=$7, supplier_ID=$8, barcode=$9, quantity=$10  WHERE product_id=$11 returning *",
    [
      name,
      description,
      category_id,
      product_image,
      unit_id,
      buying_ppu,
      retail_ppu,
      supplier_id,
      barcode,
      quantity,
      id,
    ]
  );
};
const getProductWithCategory = () => {
  return pool.query(
    `select product.* , category.name as "category_name" from product left join category on product.category_id = category.category_id`
  );
};

const getProductsBySupplierId = (id) => {
  return pool.query(
    `select product.* , category.name as "category_name" from product left join category on product.category_id = category.category_id where supplier_id = $1`,
    [id]
  );
};

module.exports = {
  getProducts,
  getProduct,
  addProduct,
  updateProduct,
  getProductWithCategory,
  getProductsBySupplierId,
};
