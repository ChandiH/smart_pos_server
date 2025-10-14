import { pool } from "../config/config";

const getInventory = () => {
  return pool.query(`select inventory.*, branch.branch_city as "branch_name"
  from inventory inner join branch on branch.branch_id = inventory.branch_id`);
};

const getInventoryByBranchId = (id) => {
  return pool.query(
    `select inventory.* from inventory where inventory.branch_id = $1`,
    [id]
  );
};

const getInventoryByProductId = (id) => {
  return pool.query(
    `select inventory.*, product.*, branch.branch_city as branch_name, category.category_name 
    from inventory 
    inner join product on inventory.product_id=product.product_id 
    inner join branch on branch.branch_id =inventory.branch_id 
    inner join category on category.category_id=product.category_id 
    where inventory.product_id =$1;`,
    [id]
  );
};

const addNewEntry = (product_id, branch_id, quantity, reorder_level) => {
  return pool.query(
    `INSERT INTO inventory (product_id, branch_id, quantity, reorder_level)
    VALUES ($1, $2, $3, $4) returning *`,
    [product_id, branch_id, quantity, reorder_level]
  );
};

const checkInventory = async (branch_id, product_id) => {
  const result = await pool.query(
    `select 1
    from inventory
    where product_id=$1 and branch_id=$2`,
    [product_id, branch_id]
  );
  return result.rowCount > 0;
};

const updateInventory = (product_id, branch_id, quantity, reorder_level) => {
  return pool.query(
    `UPDATE inventory SET quantity=$1, reorder_level= $2
    WHERE product_id= $3 and branch_id=$4 returning *`,
    [quantity, reorder_level, product_id, branch_id]
  );
};

module.exports = {
  getInventory,
  getInventoryByBranchId,
  getInventoryByProductId,
  addNewEntry,
  checkInventory,
  updateInventory,
};
