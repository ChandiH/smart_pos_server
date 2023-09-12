const pool = require("../config/config");

const getInventory = () => {
  return pool.query(`SELECT inventory.*, branch.city as "branch_name"
  FROM inventory inner join branch on branch.id = inventory.branch_id`);
};

const getInventoryByBranchId = (branchId) => {
  return pool.query(
    `SELECT inventory.* FROM inventory WHERE inventory.branch_id = $1`,
    [branchId]
  );
};

const getInventoryByProductId = (productId) => {
  return pool.query(
    `SELECT inventory.*, product.*, branch.city as branch_name, category.name as category_name 
    FROM inventory 
    inner join product on inventory.product_id=product.product_id 
    inner join branch on branch.id=inventory.branch_id 
    inner join category on category.category_id=product.category_id 
    WHERE inventory.product_id =$1;`,
    [productId]
  );
};
module.exports = {
  getInventory,
  getInventoryByBranchId,
  getInventoryByProductId,
};
