import type { QueryResult } from "pg";
import { pool } from "../config/config";

type BranchRow = Record<string, unknown>;

const getBranches = (): Promise<QueryResult<BranchRow>> => {
  return pool.query<BranchRow>("select * from branch");
};

const getBranch = (id: string): Promise<QueryResult<BranchRow>> => {
  return pool.query<BranchRow>("select * from branch where branch_id = $1", [
    id,
  ]);
};

const addBranch = (
  branch_city: string,
  branch_address: string,
  branch_phone: string,
  branch_email: string
): Promise<QueryResult<BranchRow>> => {
  return pool.query<BranchRow>(
    `INSERT INTO branch(
      branch_city, branch_address, branch_phone, branch_email)
      VALUES ($1, $2, $3, $4) returning *`,
    [branch_city, branch_address, branch_phone, branch_email]
  );
};

const updateBranch = (
  id: string,
  branch_city: string,
  branch_address: string,
  branch_phone: string,
  branch_email: string
): Promise<QueryResult<BranchRow>> => {
  return pool.query<BranchRow>(
    "update branch set branch_city=$1, branch_address=$2, branch_phone=$3, branch_email=$4 where branch_id=$5 returning *",
    [branch_city, branch_address, branch_phone, branch_email, id]
  );
};

const branchModel = {
  getBranches,
  getBranch,
  addBranch,
  updateBranch,
};

export { getBranches, getBranch, addBranch, updateBranch };
export default branchModel;
