import { Router } from "express";
import { AddBranch, GetBranchByID, GetBranches, UpdateBranchByID } from "../controllers/branch.controller";

const router = Router();

router.get("/", GetBranches);
router.get("/:id", GetBranchByID);
router.post("/", AddBranch);
router.put("/:id", UpdateBranchByID);

export default router;
