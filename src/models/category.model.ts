import type { QueryResult } from "pg";
import { pool } from "../config/config";

type CategoryRow = Record<string, unknown>;

const getAllCategories = (): Promise<QueryResult<CategoryRow>> => {
  return pool.query<CategoryRow>("select * from category");
};

const getCategory = (id: string): Promise<QueryResult<CategoryRow>> => {
  return pool.query<CategoryRow>("select * from category where category_id=$1", [
    id,
  ]);
};

const addCategory = (
  category_name: string
): Promise<QueryResult<CategoryRow>> => {
  return pool.query<CategoryRow>(
    "insert into  category (category_name) values ($1) returning *",
    [category_name]
  );
};

const updateCategory = (
  id: string,
  category_name: string
): Promise<QueryResult<CategoryRow>> => {
  return pool.query<CategoryRow>(
    "update category set category_name=$1 where category_id= $2 returning *",
    [category_name, id]
  );
};

const categoryModel = {
  getAllCategories,
  getCategory,
  addCategory,
  updateCategory,
};

export { getAllCategories, getCategory, addCategory, updateCategory };
export default categoryModel;
