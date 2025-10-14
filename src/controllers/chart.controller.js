const Chart = require("../models/chart.model");

module.exports = {
  getDailySalesForbranch(req, res, next) {
    const { year_month, branch_id } = req.params;
    Chart.getDailySalesForbranch(year_month, branch_id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getSalesView(req, res, next) {
    const { id } = req.params;
    Chart.getSalesView(id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getMonthlySummary(req, res, next) {
    Chart.getMonthlySummary()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getTopSellingBranch(req, res, next) {
    const { target_month } = req.params;
    Chart.getTopSellingBranch(target_month)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getMonths(req, res, next) {
    Chart.getMonths()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },

  getTopSellingProduct(req, res, next) {
    Chart.getTopSellingProduct()
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  }
};
