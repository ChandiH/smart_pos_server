const express = require("express");
const {
  getUserRoles,
  addUserRole,
  getAccessList,
  deleteUserRole,
  updateUserAccess,
} = require("../controllers/userRole.controller");
const router = express.Router();

router.get("/", getUserRoles);
router.post("/", addUserRole);
router.post("/update", updateUserAccess);
router.delete("/:id", deleteUserRole);
router.get("/access", getAccessList);

module.exports = router;
