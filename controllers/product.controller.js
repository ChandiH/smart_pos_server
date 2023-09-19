const Product = require("../models/product.model");
const { deleteImage } = require("../utils/fileHandler");

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

  async addProduct(req, res, next) {
    const {
      product_name,
      product_desc,
      category_id,
      product_image,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
    } = req.body;
    console.log(req.body);
    console.log(req.files);
    // check whether barcode already exists
    const barcode = await Product.isBarcodeTaken(product_barcode);
    if (barcode) {
      for (let i = 0; i < req.files.length; i++) {
        deleteImage(req.files[i].path);
      }
      return res.status(400).json({
        error: { product_barcode: "Barcode is already exists in the system" },
      });
    }

    const imagePath = [];
    for (let i = 0; i < req.files.length; i++) {
      imagePath.push(req.files[i].filename);
    }

    Product.addProduct(
      product_name,
      product_desc,
      category_id,
      imagePath,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode
    )

      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  updateProduct(req, res, next) {
    const { id } = req.params;
    const {
      product_name,
      product_desc,
      category_id,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
      product_image,
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
      id
    )
      .then((data) => {
        if (data.rows && data.rows.length > 0) {
          res.status(200).json({ message: "Product updated successfully" });
          console.log(data.rows);
        }
      })
      .catch((err) => {
        console.error(err);
        res.status(400).json({ error: err.message });
      });
  },

  getProductsWithCategory(req, res, next) {
    Product.getProductWithCategory()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getProductsBySupplierId(req, res, next) {
    const { id } = req.params;
    Product.getProductsBySupplierId(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
