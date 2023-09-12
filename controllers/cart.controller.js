const Cart = require("../models/cart.model");

module.exports = {
  createCart(req, res, next) {
    const { cashier_id } = req.body;
    Cart.createCart(cashier_id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  addProductToCart(req, res, next) {
    const { product_id, quantity } = req.body;
    Cart.addProductToCart(product_id, quantity)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  updateProductInCart(req, res, next) {
    const { id } = req.params;
    const { quantity } = req.body;
    Cart.updateProductInCart(id, quantity)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getProductInCart(req, res, next) {
    const { id } = req.params;
    Cart.getProductInCart(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getCurrentCart(req, res, next) {
    const { id } = req.params;
    Cart.getCurrentCart(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  // paymentcompleted
  paymentCompleted(req, res, next) {
    const { id } = req.params;
    Cart.paymentCompleted(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
