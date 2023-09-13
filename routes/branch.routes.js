const express = require("express");
const { getBranches, getBranch } = require("../controllers/branch.controller");
const router = express.Router();

router.get("/", getBranches);
router.get("/:id", getBranch);

module.exports = router;
