import prisma from "../config/prisma";

export const getInventory = async () => {
  return await prisma.inventory.findMany({
    include: {
      branch: {
        select: {
          branch_city: true,
        },
      },
    },
  });
};

export const getInventoryByBranchId = async (id: string) => {
  return await prisma.inventory.findMany({
    where: { branch_id: id },
    include: {
      branch: {
        select: {
          branch_city: true,
        },
      },
    },
  });
};

export const getInventoryWithProduct = async () => {
  return await prisma.product.findMany({
    include: {
      inventory: true,
      category: true,
      supplier: true,
      variants: true,
    },
  });
};

export const getInventoryByProductId = async (id: string) => {
  return await prisma.product.findUnique({
    where: { product_id: id },
    include: {
      inventory: true,
      category: true,
    },
  });
};

export const addNewEntry = async (product_id: string, branch_id: string, quantity: number, reorder_level: number) => {
  return await prisma.inventory.create({
    data: {
      product_id,
      branch_id,
      quantity,
      reorder_level,
    },
  });
};

export const checkInventory = async (branch_id: string, product_id: string): Promise<boolean> => {
  const result = await prisma.inventory.findFirst({
    where: {
      product_id,
      branch_id,
    },
  });
  return result !== null;
};
export const updateInventory = async (
  product_id: string,
  branch_id: string,
  quantity: number,
  reorder_level: number
) => {
  return await prisma.inventory.updateMany({
    where: {
      product_id,
      branch_id,
    },
    data: {
      quantity,
      reorder_level,
    },
  });
};
