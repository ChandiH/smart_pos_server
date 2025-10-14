import type { QueryResult } from "pg";
import { pool } from "../config/config";

type ProductRow = Record<string, unknown>;

const getProducts = (): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
    "select product.*, category.category_name from product inner join category on product.category_id = category.category_id order by product_id asc"
  );
};

const getProduct = (id: string): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>("select * from product where product_id = $1", [
    id,
  ]);
};

const addProduct = (
  product_name: string,
  product_desc: string,
  category_id: number | string,
  product_image: string[],
  buying_price: number | string,
  retail_price: number | string,
  discount: number | string,
  supplier_id: number | string,
  product_barcode: string
): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
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

const deleteProduct = (id: string): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
    "update product set removed=true where product_id=$1",
    [id]
  );
};

const updateProduct = (
  product_name: string,
  product_desc: string,
  category_id: number | string,
  buying_price: number | string,
  retail_price: number | string,
  discount: number | string,
  supplier_id: number | string,
  product_barcode: string,
  product_image: string[],
  id: string
): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
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

const updateProductDiscount = (
  product_id: string,
  discount: number | string
): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
    `update product
  set discount= $1 where product_id= $2`,
    [discount, product_id]
  );
};

const getProductWithCategory = (): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
    `select product.* , category.category_name from product left join category on product.category_id = category.category_id`
  );
};

const getProductsBySupplierId = (
  id: string
): Promise<QueryResult<ProductRow>> => {
  return pool.query<ProductRow>(
    `select product.* , category.category_name from product left join category on product.category_id = category.category_id where supplier_id = $1`,
    [id]
  );
};

const isBarcodeTaken = async (barcode: string): Promise<boolean> => {
  const result = await pool.query(
    `SELECT 1 FROM product where product_barcode = $1 LIMIT 1`,
    [barcode]
  );
  return (result.rowCount ?? 0) > 0;
};

const productModel = {
  getProducts,
  getProduct,
  addProduct,
  deleteProduct,
  updateProduct,
  updateProductDiscount,
  getProductWithCategory,
  getProductsBySupplierId,
  isBarcodeTaken,
};

export {
  getProducts,
  getProduct,
  addProduct,
  deleteProduct,
  updateProduct,
  updateProductDiscount,
  getProductWithCategory,
  getProductsBySupplierId,
  isBarcodeTaken,
};
export default productModel;
