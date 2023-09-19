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
  async addSupplier(req, res, next) {
    const { supplier_name, supplier_email, supplier_phone, supplier_address } =
      req.body;
    console.log(req.body);

    // check whether email already exists
    const email = await Supplier.isEmailTaken(supplier_email);
    if (email > 0)
      return res
        .status(400)
        .json({ error: { supplier_email: "Email already exists" } });

    Supplier.addSupplier(
      supplier_name,
      supplier_email,
      supplier_phone,
      supplier_address
    )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
