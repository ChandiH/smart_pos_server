const pool = require("../config/config");

const insertSalesData = (salesData) => {
  return pool.query("CALL insert_sales_data_and_update($1::jsonb)", 
  [salesData]
  );
};
const getRewardsPointsPercentage = () => {
  return pool.query(
    "SELECT variable_value FROM variable_options WHERE variable_name = 'rewards_points_percentage'"
  );
};

const updateRewardsPointsPercentage = (rewardsPointsPercentage) => {
  return pool.query(
    "UPDATE variable_options SET variable_value = $1 WHERE variable_id = 1",
    [rewardsPointsPercentage]
  );
};

module.exports = {
  insertSalesData,
  getRewardsPointsPercentage,
  updateRewardsPointsPercentage,
};
