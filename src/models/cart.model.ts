import prisma from "../config/prisma";

export const insertSalesData = async (salesData: unknown) => {
  return await prisma.$queryRaw`CALL insert_sales_data_and_update(${salesData})`;
};

export const getRewardsPointsPercentage = async () => {
  return await prisma.variable_options.findUnique({
    where: { variable_name: "rewards_points_percentage" },
    select: { variable_value: true },
  });
};

export const updateRewardsPointsPercentage = async (rewardsPointsPercentage: number) => {
  return await prisma.variable_options.update({
    where: { variable_name: "rewards_points_percentage" },
    data: { variable_value: rewardsPointsPercentage },
  });
};
