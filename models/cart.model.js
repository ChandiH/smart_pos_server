const pool = require("../config/config");

const insertSalesData = (salesData) => {
  return pool.query(
    `
    SELECT insert_sales_data($1::jsonb)`,
    [salesData]
  );
};
const getRewardsPointsPercentage = () => {
  return pool.query(
`SELECT variable_value FROM variable_options WHERE variable_name = 'rewards_points_percentage'
`    );
}
module.exports = {
  insertSalesData,
  getRewardsPointsPercentage,
};
