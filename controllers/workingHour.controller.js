const Record = require("../models/workingHour.model");

module.exports = {
  getEmployeeRecordByDate(req, res, next) {
    const { date } = req.params;
    Record.getEmployeeRecordByDate(date)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getEmployeeRecordByBranch(req, res, next) {
    const { branch_id } = req.params;
    Record.getEmployeeRecordByBranch(branch_id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  getEmployeeRecordByDateBranch(req, res, next) {
    const { branch_id, date } = req.params;
    Record.getEmployeeRecordByDateBranch(date, branch_id)
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
  addEmployeeRecord(req, res, next) {
    const {
      employee_id,
      date,
      shift_on,
      shift_off,
      updated_by,
      present,
      total_hours,
    } = req.body;

    Record.addEmployeeRecord(
      employee_id,
      date,
      shift_on,
      shift_off,
      updated_by,
      present,
      total_hours
    )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  },
};
