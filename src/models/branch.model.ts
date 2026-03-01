import prisma from "../config/prisma";

export const getBranches = async () => {
  return await prisma.branch.findMany();
};

export const getBranch = async (id: string) => {
  return await prisma.branch.findUnique({
    where: {
      branch_id: id,
    },
  });
};

export const addBranch = async (
  branch_city: string,
  branch_address: string,
  branch_phone: string,
  branch_email: string
) => {
  return await prisma.branch.create({
    data: {
      branch_city,
      branch_address,
      branch_phone,
      branch_email,
    },
  });
};

export const updateBranch = async (
  id: string,
  branch_city: string,
  branch_address: string,
  branch_phone: string,
  branch_email: string
) => {
  return await prisma.branch.update({
    where: {
      branch_id: id,
    },
    data: {
      branch_city,
      branch_address,
      branch_phone,
      branch_email,
    },
  });
};
