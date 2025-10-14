const express = require("express");
const { getBranches, getBranch,addBranch, updateBranch} = require("../controllers/branch.controller");
const router = express.Router();

router.get("/", getBranches);
router.get("/:id", getBranch);
router.post("/", addBranch);
router.put("/:id", updateBranch);


module.exports = router;
