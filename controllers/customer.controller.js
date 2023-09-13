const Customer = require("../models/customer.model");

module.exports = {
  getCustomers(req, res, next) {
    Customer.getCustomers()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getCustomer(req, res, next) {
    const { id } = req.params;
    console.log(req.headers);
    Customer.getCustomer(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  addCustomer(req, res, next) {
    const { name, email, phone, address } = req.body;
    console.log(req.body);
    Customer.addCustomer(name, email, phone, address)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  updateCustomer(req, res, next) {
    const { id } = req.params;
    const { name, email, phone, address } = req.body;
    Customer.updateCustomer(id, name, email, phone, address)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  findEmail(req, res, next) {
    const { email } = req.params;
    Customer.findEmail(email)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  findPhone(req, res, next) {
    const { phone } = req.params;
    Customer.findPhone(phone)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
