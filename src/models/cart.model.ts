import prisma from "../config/prisma";

export const getRewardsPointsPercentage = async () => {
  return await prisma.variable_options.findUnique({
    where: { variable_name: "rewards_points_percentage" },
    select: { variable_value: true },
  });
};

export const updateRewardsPointsPercentage = async (rewardsPointsPercentage: number) => {
  return await prisma.variable_options.upsert({
    where: { variable_name: "rewards_points_percentage" },
    update: { variable_value: rewardsPointsPercentage },
    create: { variable_name: "rewards_points_percentage", variable_value: rewardsPointsPercentage },
  });
};
