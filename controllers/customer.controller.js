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
    const { customer_name, customer_email, customer_phone, customer_address } = req.body;
    console.log(req.body);
    Customer.addCustomer(customer_name, customer_email, customer_phone, customer_address )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  updateCustomer(req, res, next) {
    const { id } = req.params;
    const { customer_name, customer_email, customer_phone, customer_address } = req.body;
    Customer.updateCustomer(id, customer_name, customer_email, customer_phone, customer_address )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },


};
