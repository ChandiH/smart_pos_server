import type { RequestHandler } from "express";
import Cart from "../models/cart.model";

type CartModel = {
  insertSalesData: (salesData: unknown) => Promise<unknown>;
  getRewardsPointsPercentage: () => Promise<{ rows: unknown[] }>;
  updateRewardsPointsPercentage: (percentage: number) => Promise<unknown>;
};

const cartModel = Cart as CartModel;

interface InsertSalesBody {
  salesData: unknown;
}

const insertSalesData: RequestHandler<unknown, unknown, InsertSalesBody> =
  async (req, res) => {
    try {
      const { salesData } = req.body;
      await cartModel.insertSalesData(salesData);
      return res
        .status(200)
        .json({ message: "Sales data inserted successfully" });
    } catch (error: unknown) {
      const message =
        error instanceof Error ? error.message : "Failed to insert sales data";
      console.error(error);
      return res.status(400).json({ error: message });
    }
  };

const getRewardsPointsPercentage: RequestHandler = async (_req, res) => {
  try {
    const rewardsPointsPercentage =
      await cartModel.getRewardsPointsPercentage();
    return res.status(200).json(rewardsPointsPercentage.rows);
  } catch (error: unknown) {
    const message =
      error instanceof Error
        ? error.message
        : "Failed to fetch rewards points percentage";
    console.error(error);
    return res.status(400).json({ error: message });
  }
};

interface UpdateRewardsBody {
  rewardsPointsPercentage: number;
}

const updateRewardsPointsPercentage: RequestHandler<
  unknown,
  unknown,
  UpdateRewardsBody
> = async (req, res) => {
  try {
    const { rewardsPointsPercentage } = req.body;
    await cartModel.updateRewardsPointsPercentage(rewardsPointsPercentage);
    return res.status(200).json({
      message: "Rewards points percentage updated successfully",
    });
  } catch (error: unknown) {
    const message =
      error instanceof Error
        ? error.message
        : "Failed to update rewards points percentage";
    console.error(error);
    return res.status(400).json({ error: message });
  }
};

export default {
  insertSalesData,
  getRewardsPointsPercentage,
  updateRewardsPointsPercentage,
};
