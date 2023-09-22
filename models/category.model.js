const pool = require("../config/config");

const getAllCategories = () => {
  return pool.query("select * from category");
};

const getCategory = (id) => {
  return pool.query("select * from category where category_id=$1", [id]);
};

const addCategory = (category_name) => {
  return pool.query("insert into  category (category_name) values ($1) returning *", [
    category_name,
  ]);
};

const updateCategory = (id,category_name) => {
  return pool.query(
    "update category set category_name=$1 where category_id= $2 returning *",
    [category_name, id]
  );
};

module.exports = {
  getAllCategories,
  getCategory,
  addCategory,
  updateCategory,
};
