const Product = require("../models/product.model");

module.exports = {

  getProducts(req, res, next) {
    Product.getProducts()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getProduct(req, res, next) {
    const { id } = req.params;
    Product.getProduct(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  addProduct(req, res, next) {
    const { product_name,
      product_desc,
      category_id,
      product_image,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode } = req.body;
    Product.addProduct(
      product_name,
      product_desc,
      category_id,
      product_image,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode)

      .then((data) => {
        if (data.rows && data.rows.length > 0) {
          res.status(200).json({ message: 'Product added successfully' })
          console.log(data.rows);
        }
      })
      .catch((err) => {
        console.error(err);
        res.status(400).json({ error: err.message });
      }

      );
  },


  updateProduct(req, res, next) {
    const { id } = req.params;
    const { product_name,
      product_desc,
      category_id,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
      product_image
    } = req.body;
    Product.updateProduct(
      product_name,
      product_desc,
      category_id,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
      product_image,
      id)
      .then((data) => {
        if (data.rows && data.rows.length > 0) {
          res.status(200).json({ message: 'Product updated successfully' })
          console.log(data.rows);
        }
      })
      .catch((err) => {
        console.error(err);
        res.status(400).json({ error: err.message });
      }
      );
  },


  // getProductsWithCategory(req, res, next) {
  //   Product.getProductsWithCategory()
  //     .then((data) => res.status(200).json(data.rows))
  //     .catch((err) => res.status(400).json({ error: err }));
  // },

};
