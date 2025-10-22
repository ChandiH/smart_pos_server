import type { RequestHandler } from "express";
import { getRewardsPointsPercentage, insertSalesData, updateRewardsPointsPercentage } from "../models/cart.model";

interface InsertSalesBody {
  salesData: unknown;
}

interface UpdateRewardsBody {
  rewardsPointsPercentage: number;
}

export const InsertSalesData: RequestHandler<unknown, unknown, InsertSalesBody> = async (req, res) => {
  try {
    const { salesData } = req.body;
    await await insertSalesData(salesData);
    return res.status(200).json({ message: "Sales data inserted successfully" });
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : "Failed to insert sales data";
    console.error(error);
    return res.status(400).json({ error: message });
  }
};

export const GetRewardsPointsPercentage: RequestHandler = async (_req, res) => {
  try {
    const rewardsPointsPercentage = await getRewardsPointsPercentage();
    return res.status(200).json({ data: rewardsPointsPercentage });
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : "Failed to fetch rewards points percentage";
    console.error(error);
    return res.status(400).json({ error: message });
  }
};

export const UpdateRewardsPointsPercentage: RequestHandler<unknown, unknown, UpdateRewardsBody> = async (req, res) => {
  try {
    const { rewardsPointsPercentage } = req.body;
    await updateRewardsPointsPercentage(rewardsPointsPercentage);
    return res.status(200).json({
      message: "Rewards points percentage updated successfully",
    });
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : "Failed to update rewards points percentage";
    console.error(error);
    return res.status(400).json({ error: message });
  }
};
