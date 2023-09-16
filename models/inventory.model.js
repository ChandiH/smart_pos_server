const pool = require("../config/config");

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
module.exports = {
  getInventory,
  getInventoryByBranchId,
  getInventoryByProductId,
};
