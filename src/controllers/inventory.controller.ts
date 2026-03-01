import type { RequestHandler } from "express";
import {
  addNewEntry,
  checkInventory,
  getInventory,
  getInventoryByBranchId,
  getInventoryByProductId,
  getInventoryWithProduct,
  updateInventory,
} from "../models/inventory.model";

interface UpdateInventoryBody {
  branch_id: string;
  product_id: string;
  quantity: number;
  reorder_level: number;
}

export const GetInventory: RequestHandler = async (_req, res) => {
  return await getInventory()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetInventoryByBranchId: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getInventoryByBranchId(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetInventoryWithProduct: RequestHandler = async (_req, res) => {
  return await getInventoryWithProduct()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetInventoryByProductId: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getInventoryByProductId(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateInventory: RequestHandler<unknown, unknown, UpdateInventoryBody> = async (req, res) => {
  const { branch_id, product_id, quantity, reorder_level } = req.body;
  const branchId = String(branch_id);
  const productId = String(product_id);

  try {
    const inventoryExists = await checkInventory(branchId, productId);

    console.log(inventoryExists);

    if (inventoryExists) {
      return await updateInventory(productId, branchId, quantity, reorder_level)
        .then((data) => res.status(200).json({ data }))
        .catch((err) => res.status(400).json({ error: err }));
    }

    return await addNewEntry(productId, branchId, quantity, reorder_level)
      .then((data) => res.status(200).json({ data }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error });
  }
};
