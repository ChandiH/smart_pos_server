import prisma from "../config/prisma";

export const getAllCategories = async () => {
  return await prisma.category.findMany();
};

export const getCategory = async (id: string) => {
  return await prisma.category.findUnique({
    where: {
      category_id: Number(id),
    },
  });
};

export const addCategory = async (category_name: string) => {
  return await prisma.category.create({
    data: {
      category_name,
    },
  });
};

export const updateCategory = async (id: string, category_name: string) => {
  return await prisma.category.update({
    where: {
      category_id: Number(id),
    },
    data: {
      category_name,
    },
  });
};
