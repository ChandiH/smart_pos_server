const Branch = require("../models/branch.model");

module.exports = {
  getBranches(req, res, next) {
    Branch.getAllBranch()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getBranch(req, res, next) {
    const { id } = req.params;
    Branch.getBranch(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
