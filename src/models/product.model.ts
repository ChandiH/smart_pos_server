import { prisma } from "../config/prisma";

export const getProducts = async () => {
  return await prisma.product.findMany({
    include: {
      category: true,
    },
    orderBy: {
      product_id: "asc",
    },
  });
};

export const getProduct = async (id: string) => {
  return await prisma.product.findUnique({
    where: { product_id: id },
    include: {
      category: true,
    },
  });
};

export const addProduct = async (
  product_name: string,
  product_desc: string,
  category_id: number | string,
  product_image: string[],
  buying_price: number | string,
  retail_price: number | string,
  discount: number | string,
  supplier_id: number | string,
  product_barcode: string
) => {
  return await prisma.product.create({
    data: {
      product_name,
      product_desc,
      category_id: Number(category_id),
      product_image,
      buying_price: Number(buying_price),
      retail_price: Number(retail_price),
      discount: Number(discount),
      supplier_id: Number(supplier_id),
      product_barcode,
    },
  });
};

export const deleteProduct = async (id: string) => {
  return await prisma.product.update({
    where: { product_id: id },
    data: { removed: true },
  });
};

export const updateProduct = async (
  product_name: string,
  product_desc: string,
  category_id: number | string,
  buying_price: number | string,
  retail_price: number | string,
  discount: number | string,
  supplier_id: number | string,
  product_barcode: string,
  product_image: string[],
  id: string
) => {
  return await prisma.product.update({
    where: { product_id: id },
    data: {
      product_name,
      product_desc,
      category_id: Number(category_id),
      buying_price: Number(buying_price),
      retail_price: Number(retail_price),
      discount: Number(discount),
      supplier_id: Number(supplier_id),
      product_barcode,
      product_image,
    },
  });
};

export const updateProductDiscount = async (product_id: string, discount: number | string) => {
  return await prisma.product.update({
    where: { product_id },
    data: { discount: Number(discount) },
  });
};

export const getProductWithCategory = async () => {
  return await prisma.product.findMany({
    include: {
      category: true,
    },
  });
};

export const getProductsBySupplierId = async (id: string) => {
  return await prisma.product.findMany({
    where: { supplier_id: Number(id) },
    include: {
      category: true,
    },
  });
};

export const isBarcodeTaken = async (barcode: string): Promise<boolean> => {
  const result = await prisma.product.findUnique({
    where: { product_barcode: barcode },
  });
  return result !== null;
};
