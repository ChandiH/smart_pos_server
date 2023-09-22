const Category = require("../models/category.model");

module.exports = {
  getCategories(req, res, next) {
    Category.getAllCategories()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getCategory(req, res, next) {
        Category.getCategory(req.params.id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  addCategory(req, res, next) {
    Category.addCategory(req.body.category_name)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  updateCategory(req, res, next) {
    Category.updateCategory(req.params.id, req.body.category_name)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
