const express = require("express");
const { login, register , resetPassword } = require("../controllers/auth.controller");

const router = express.Router();

router.post("/login", login);
router.post("/register", register);
router.put("/resetPassword", resetPassword);

module.exports = router;
