const pool = require("../config/config");

const getProducts = () => {
  return pool.query(
    "select product.*, category.category_name from product inner join category on product.category_id = category.category_id order by product_id asc"
  );
};

const getProduct = (id) => {
  return pool.query("select * from product where product_id = $1", [id]);
};

const addProduct = (
  product_name,
  product_desc,
  category_id,
  product_image,
  buying_price,
  retail_price,
  discount,
  supplier_id,
  product_barcode
) => {
  return pool.query(
    `insert into product(
     product_name, product_desc, category_id, product_image, buying_price, retail_price, discount, supplier_id, product_barcode)
     values ($1 , $2, $3, $4, $5, $6, $7, $8, $9 ) returning *`,
    [
      product_name,
      product_desc,
      category_id,
      product_image,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
    ]
  );
};

const deleteProduct = (id) => {
  return pool.query("update product set removed=true where product_id=$1", [
    id,
  ]);
};

const updateProduct = (
  product_name,
  product_desc,
  category_id,
  buying_price,
  retail_price,
  discount,
  supplier_id,
  product_barcode,
  product_image,
  id
) => {
  return pool.query(
    `update product
    set product_name= $1 ,product_desc= $2, category_id= $3, 
     buying_price= $4, retail_price= $5, discount= $6, supplier_id= $7, product_barcode = $8,product_image = Array[$9]
    where product_id= $10 returning *`,
    [
      product_name,
      product_desc,
      category_id,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
      product_image,
      id,
    ]
  );
};

const getProductWithCategory = () => {
  return pool.query(
    `select product.* , category.category_name from product left join category on product.category_id = category.category_id`
  );
};

const getProductsBySupplierId = (id) => {
  return pool.query(
    `select product.* , category.category_name from product left join category on product.category_id = category.category_id where supplier_id = $1`,
    [id]
  );
};

const isBarcodeTaken = async (barcode) => {
  const result = await pool.query(
    `SELECT 1 FROM product where product_barcode = $1 LIMIT 1`,
    [barcode]
  );
  return result.rowCount > 0;
};

module.exports = {
  getProducts,
  getProduct,
  addProduct,
  deleteProduct,
  updateProduct,
  getProductWithCategory,
  getProductsBySupplierId,
  isBarcodeTaken,
};
