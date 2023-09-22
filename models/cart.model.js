const pool = require("../config/config");

const insertSalesData = (salesData) => {
  return pool.query(
    `
    SELECT insert_sales_data($1::jsonb)`,
    [salesData]
  );
};

module.exports = {
  insertSalesData,
};
