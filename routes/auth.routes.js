const express = require("express");
const { login } = require("../controllers/auth.controller");
const { register } = require("../controllers/auth.controller");


const router = express.Router();

router.post("/login", login);
router.post("/register", register);


module.exports = router;
