import type { RequestHandler } from "express";
import Branch from "../models/branch.model";

type BranchModel = {
  getBranches: () => Promise<{ rows: unknown[] }>;
  getBranch: (id: string) => Promise<{ rows: unknown[] }>;
  addBranch: (
    branchCity: string,
    branchAddress: string,
    branchPhone: string,
    branchEmail: string
  ) => Promise<{ rows: unknown[] }>;
  updateBranch: (
    id: string,
    branchCity: string,
    branchAddress: string,
    branchPhone: string,
    branchEmail: string
  ) => Promise<{ rows: unknown[] }>;
};

const branchModel = Branch as BranchModel;

const getBranches: RequestHandler = (_req, res) => {
  return branchModel
    .getBranches()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getBranch: RequestHandler = (req, res) => {
  const { id } = req.params;
  return branchModel
    .getBranch(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const addBranch: RequestHandler = (req, res) => {
  const { branch_city, branch_address, branch_phone, branch_email } = req.body;

  return branchModel
    .addBranch(branch_city, branch_address, branch_phone, branch_email)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const updateBranch: RequestHandler = (req, res) => {
  const { id } = req.params;
  const { branch_city, branch_address, branch_phone, branch_email } = req.body;

  return branchModel
    .updateBranch(id, branch_city, branch_address, branch_phone, branch_email)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

export default {
  getBranches,
  getBranch,
  addBranch,
  updateBranch,
};
