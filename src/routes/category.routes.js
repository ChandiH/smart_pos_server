const express = require("express");

const {
    getCategories,
    getCategory,
    addCategory,
    updateCategory,
  } = require("../controllers/category.controller");

const router = express.Router();

router.get("/", getCategories);
router.post("/", addCategory);
router.get("/:id", getCategory);
router.put("/:id", updateCategory);


module.exports = router;