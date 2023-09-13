const pool = require("../config/config");

const getProducts = () => {
  return pool.query("select * from product");
};

const getProduct = (id) => {
  return pool.query("select * from product where product_id=$1", [id]);
};

const addProduct = (
  product_name,
  products_desc,
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
    "INSERT INTO product (product_name, products_desc, category_ID, product_image, unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity) VALUES  ($1, $2, $3, $4, $5 , $6,$7,$8,$9,$10) returning *",
    [
      product_name,
      products_desc,
      category_id,
      product_image,
      unit_id,
      buying_ppu,
      retail_ppu,
      supplier_id,
      barcode,
      quantity,
    ]
  );
};

const updateProduct = (
  id,
  product_name,
  products_desc,
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
    "UPDATE product SET product_name=$1, products_desc=$2, category_ID=$3, product_image=$4, unit_id=$5, buying_ppu=$6, retail_ppu=$7, supplier_ID=$8, barcode=$9, quantity=$10  WHERE product_id=$11 returning *",
    [
      product_name,
      products_desc,
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

module.exports = {
  getProducts,
  getProduct,
  addProduct,
  updateProduct,
  getProductWithCategory,
};
