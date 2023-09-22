const pool = require("../config/config");

// call daily chart
const getDailySalesForbranch = (year_month,branch_id) => {
  //SELECT * FROM branch_monthly_sales('2023-09', 1);
  console.log("year_month",year_month);
  console.log("branch_id",branch_id);
  return pool.query("SELECT day,total_sales FROM branch_monthly_sales($1,$2) order by day ", [year_month ,branch_id]);
}


module.exports = {
  getDailySalesForbranch,
};

