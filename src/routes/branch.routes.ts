import { Router } from "express";
import {
  addNewBranch,
  getAllBranches,
  getBranchByID,
  updateBranchByID,
} from "../controllers/branch.controller";

const router = Router();

router.get("/", getAllBranches);
router.get("/:id", getBranchByID);
router.post("/", addNewBranch);
router.put("/:id", updateBranchByID);

export default router;
