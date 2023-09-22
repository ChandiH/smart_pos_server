const Chart = require('../models/chart.model');


module.exports = {
  getDailySalesForbranch(req, res, next) {
    const { year_month, branch_id } = req.params;
    Chart.getDailySalesForbranch(year_month, branch_id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
}

  