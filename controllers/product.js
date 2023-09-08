const Product = require("../models/Product");

module.exports = {
  getProducts(req, res, next) {
    Product.getProducts()
      .then((data) => res.status(200).json(data))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getProduct(req, res, next) {
    const { id } = req.params;
    Product.getProduct(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  addProduct(req, res, next) {
    const { product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, created_on} = req.body;
    Product.addProduct(product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity, created_on)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  updateProduct(req, res, next) {
    const { id } = req.params;
    const { product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity} = req.body;
    Product.updateProduct(id, product_name, products_desc, category_ID, product_image, measure_of_unit_id, buying_ppu, retail_ppu, supplier_ID, barcode, quantity)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },


};
