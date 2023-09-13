const pool = require("../config/config");

const getAllCategories = () => {
  return pool.query("select * from category");
};

const getCategory = (id) => {
  return pool.query("select * from category where category_id=$1", [id]);
};

const addCategory = (name) => {
  return pool.query("insert into  category (name) values ($1) returning *", [
    name,
  ]);
};

const updateCategory = (id, name) => {
  return pool.query(
    "update category set name=$1 where category_id=$2 returning *",
    [name, id]
  );
};

module.exports = {
  getAllCategories,
  getCategory,
  addCategory,
  updateCategory,
};
