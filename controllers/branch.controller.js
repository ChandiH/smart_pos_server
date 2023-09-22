const Branch = require("../models/branch.model");

module.exports = {
  getBranches(req, res, next) {
    Branch.getBranches()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
   
  getBranch(req, res, next) {
    const { id } = req.params;
    Branch.getBranch(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  // addBranch
  addBranch(req, res, next) {
    const {  branch_city, branch_address, branch_phone, branch_email} = req.body;
    Branch.addBranch( branch_city, branch_address, branch_phone, branch_email)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },


  //updateBranch
  updateBranch(req, res, next) {
    const { id } = req.params;
    const {branch_city, branch_address, branch_phone, branch_email } = req.body;
    Branch.updateBranch(id,branch_city, branch_address, branch_phone, branch_email)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },




};
