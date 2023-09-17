const Supplier = require("../models/supplier.model");

module.exports = {
  getSuppliers(req, res, next) {
    Supplier.getSuppliers()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getSupplier(req, res, next) {
    const { id } = req.params;
    Supplier.getSupplier(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  addSupplier(req, res, next) {
    const { name, email, phone, address } = req.body;
    console.log(req.body);
    Supplier.addSupplier(name, email, phone, address)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
