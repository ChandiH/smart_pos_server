const Customer = require("../models/customer");

module.exports = {
  getCustomers(req, res, next) {
    Customer.getCustomers()
      .then((data) => res.status(200).json(data))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getCustomer(req, res, next) {
    const { id } = req.params;
    Customer.getCustomer(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  addCustomer(req, res, next) {
    const { name, contact } = req.body;
    Customer.addCustomer(name, contact)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
