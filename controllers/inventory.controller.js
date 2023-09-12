const Inventory = require("../models/inventory.model");

module.exports = {
  getInventory(req, res, next) {
    Inventory.getInventory()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getInventoryByBranchId(req, res, next) {
    const { id } = req.params;
    Inventory.getInventoryByBranchId(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getInevntoryByProductId(req, res, next) {
    const { id } = req.params;
    Inventory.getInventoryByProductId(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
