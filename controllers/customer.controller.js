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
  async addCustomer(req, res, next) {
    const { customer_name, customer_email, customer_phone, customer_address } =
      req.body;
    // check whether phone already exists
    const phone = await Customer.findPhone(customer_phone);
    if (phone > 0)
      return res
        .status(400)
        .json({ error: { customer_phone: "Phone already exists" } });

    // check whether email already exists
    const email = await Customer.findEmail(customer_email);
    if (email > 0)
      return res
        .status(400)
        .json({ error: { customer_email: "Email already exists" } });
    Customer.addCustomer(
      customer_name,
      customer_email,
      customer_phone,
      customer_address
    )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  updateCustomer(req, res, next) {
    const { id } = req.params;
    const { customer_name, customer_email, customer_phone, customer_address } =
      req.body;
    Customer.updateCustomer(
      id,
      customer_name,
      customer_email,
      customer_phone,
      customer_address
    )
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
