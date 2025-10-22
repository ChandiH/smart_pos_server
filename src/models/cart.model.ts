import type { QueryResult } from "pg";
import { pool } from "../config/config";

type VariableRow = {
  variable_value: string;
};

const insertSalesData = (salesData: unknown): Promise<QueryResult> => {
  return pool.query("CALL insert_sales_data_and_update($1::jsonb)", [
    salesData,
  ]);
};

const getRewardsPointsPercentage =
  (): Promise<QueryResult<VariableRow>> => {
    return pool.query<VariableRow>(
      "SELECT variable_value FROM variable_options WHERE variable_name = 'rewards_points_percentage'"
    );
  };

const updateRewardsPointsPercentage = (
  rewardsPointsPercentage: number
): Promise<QueryResult> => {
  return pool.query(
    "UPDATE variable_options SET variable_value = $1 WHERE variable_id = 1",
    [rewardsPointsPercentage]
  );
};

const cartModel = {
  insertSalesData,
  getRewardsPointsPercentage,
  updateRewardsPointsPercentage,
};

export {
  insertSalesData,
  getRewardsPointsPercentage,
  updateRewardsPointsPercentage,
};
export default cartModel;
