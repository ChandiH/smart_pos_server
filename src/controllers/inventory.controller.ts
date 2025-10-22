import type { RequestHandler } from "express";
import type { QueryResult } from "pg";
import Inventory from "../models/inventory.model";

type InventoryRow = Record<string, unknown>;

interface InventoryModel {
  getInventory: () => Promise<QueryResult<InventoryRow>>;
  getInventoryByBranchId: (id: string) => Promise<QueryResult<InventoryRow>>;
  getInventoryByProductId: (id: string) => Promise<QueryResult<InventoryRow>>;
  addNewEntry: (
    productId: number,
    branchId: number,
    quantity: number,
    reorderLevel: number
  ) => Promise<QueryResult<InventoryRow>>;
  checkInventory: (branchId: number, productId: number) => Promise<boolean>;
  updateInventory: (
    productId: number,
    branchId: number,
    quantity: number,
    reorderLevel: number
  ) => Promise<QueryResult<InventoryRow>>;
}

const inventoryModel = Inventory as InventoryModel;

const getInventory: RequestHandler = (_req, res) => {
  return inventoryModel
    .getInventory()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getInventoryByBranchId: RequestHandler = (req, res) => {
  const { id } = req.params;
  return inventoryModel
    .getInventoryByBranchId(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getInevntoryByProductId: RequestHandler = (req, res) => {
  const { id } = req.params;
  return inventoryModel
    .getInventoryByProductId(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface UpdateInventoryBody {
  branch_id: number;
  product_id: number;
  quantity: number;
  reorder_level: number;
}

const updateInventory: RequestHandler<unknown, unknown, UpdateInventoryBody> =
  async (req, res) => {
    const { branch_id, product_id, quantity, reorder_level } = req.body;

    try {
      const inventoryExists = await inventoryModel.checkInventory(
        branch_id,
        product_id
      );

      console.log(inventoryExists);

      if (inventoryExists) {
        return inventoryModel
          .updateInventory(product_id, branch_id, quantity, reorder_level)
          .then((data) => res.status(200).json(data.rows))
          .catch((err) => res.status(400).json({ error: err }));
      }

      return inventoryModel
        .addNewEntry(product_id, branch_id, quantity, reorder_level)
        .then((data) => res.status(200).json(data.rows))
        .catch((err) => res.status(400).json({ error: err }));
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error });
    }
  };

export default {
  getInventory,
  getInventoryByBranchId,
  getInevntoryByProductId,
  updateInventory,
};
