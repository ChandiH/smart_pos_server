import { Router, type RequestHandler } from "express";
import branchController from "../controllers/branch.controller";

type BranchController = {
  getBranches: RequestHandler;
  getBranch: RequestHandler;
  addBranch: RequestHandler;
  updateBranch: RequestHandler;
};

const { getBranches, getBranch, addBranch, updateBranch } =
  branchController as BranchController;

const router = Router();

router.get("/", getBranches);
router.get("/:id", getBranch);
router.post("/", addBranch);
router.put("/:id", updateBranch);

export default router;
