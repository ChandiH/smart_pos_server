import type { QueryResult } from "pg";
import { pool } from "../config/config";

type InventoryRow = Record<string, unknown>;

const getInventory = (): Promise<QueryResult<InventoryRow>> => {
  return pool.query<InventoryRow>(`select inventory.*, branch.branch_city as "branch_name"
  from inventory inner join branch on branch.branch_id = inventory.branch_id`);
};

const getInventoryByBranchId = (
  id: string
): Promise<QueryResult<InventoryRow>> => {
  return pool.query<InventoryRow>(
    `select inventory.* from inventory where inventory.branch_id = $1`,
    [id]
  );
};

const getInventoryByProductId = (
  id: string
): Promise<QueryResult<InventoryRow>> => {
  return pool.query<InventoryRow>(
    `select inventory.*, product.*, branch.branch_city as branch_name, category.category_name 
    from inventory 
    inner join product on inventory.product_id=product.product_id 
    inner join branch on branch.branch_id =inventory.branch_id 
    inner join category on category.category_id=product.category_id 
    where inventory.product_id =$1;`,
    [id]
  );
};

const addNewEntry = (
  product_id: number,
  branch_id: number,
  quantity: number,
  reorder_level: number
): Promise<QueryResult<InventoryRow>> => {
  return pool.query<InventoryRow>(
    `INSERT INTO inventory (product_id, branch_id, quantity, reorder_level)
    VALUES ($1, $2, $3, $4) returning *`,
    [product_id, branch_id, quantity, reorder_level]
  );
};

const checkInventory = async (
  branch_id: number,
  product_id: number
): Promise<boolean> => {
  const result = await pool.query(
    `select 1
    from inventory
    where product_id=$1 and branch_id=$2`,
    [product_id, branch_id]
  );
  return (result.rowCount ?? 0) > 0;
};

const updateInventory = (
  product_id: number,
  branch_id: number,
  quantity: number,
  reorder_level: number
): Promise<QueryResult<InventoryRow>> => {
  return pool.query<InventoryRow>(
    `UPDATE inventory SET quantity=$1, reorder_level= $2
    WHERE product_id= $3 and branch_id=$4 returning *`,
    [quantity, reorder_level, product_id, branch_id]
  );
};

const inventoryModel = {
  getInventory,
  getInventoryByBranchId,
  getInventoryByProductId,
  addNewEntry,
  checkInventory,
  updateInventory,
};

export {
  getInventory,
  getInventoryByBranchId,
  getInventoryByProductId,
  addNewEntry,
  checkInventory,
  updateInventory,
};
export default inventoryModel;
