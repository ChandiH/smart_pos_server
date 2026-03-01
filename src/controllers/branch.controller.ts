import type { RequestHandler } from "express";
import { getBranches, getBranch, updateBranch, addBranch } from "../models/branch.model";

export const GetBranches: RequestHandler = async (_req, res) => {
  return getBranches()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetBranchByID: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return getBranch(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddBranch: RequestHandler = async (req, res) => {
  const { branch_city, branch_address, branch_phone, branch_email } = req.body;

  return addBranch(branch_city, branch_address, branch_phone, branch_email)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateBranchByID: RequestHandler = async (req, res) => {
  const { id } = req.params;
  const { branch_city, branch_address, branch_phone, branch_email } = req.body;

  return updateBranch(id, branch_city, branch_address, branch_phone, branch_email)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
