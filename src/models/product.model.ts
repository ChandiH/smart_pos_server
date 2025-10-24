import { prisma } from "../config/prisma";
import { product, product_variants, supplier } from "../prisma";

export const getProducts = async () => {
  return await prisma.product.findMany({
    include: {
      category: true,
      variants: true,
    },
    orderBy: {
      product_id: "asc",
    },
  });
};

export const getProduct = async (id: product["product_id"]) => {
  return await prisma.product.findUnique({
    where: { product_id: id },
    include: {
      variants: true,
      category: true,
      supplier: true,
      inventory: true,
    },
  });
};

export const addProduct = async (
  data: Omit<product, "product_id" | "product_image" | "removed" | "created_at" | "updated_on">
) => {
  return await prisma.product.create({
    data,
  });
};

export const addProductWithVariants = async (
  data: Omit<product, "product_id" | "product_image" | "removed" | "created_at" | "updated_on">,
  variants: Omit<product_variants, "variant_id" | "product_id">[]
) => {
  return await prisma.$transaction(async (tx) => {
    const newProduct = await tx.product.create({
      data,
    });

    if (variants.length === 0) {
      return newProduct;
    }

    const newVariants = await Promise.all(
      variants.map((variant) =>
        tx.product_variants.create({
          data: {
            discount: variant.discount,
            buying_price: variant.buying_price,
            retail_price: variant.retail_price,
            label: variant.label,
            product_id: newProduct.product_id,
          },
        })
      )
    );

    return { ...newProduct, variants: [...newVariants] };
  });
};

export const deleteProduct = async (id: product["product_id"]) => {
  return await prisma.product.update({
    where: { product_id: id },
    data: { removed: true },
  });
};

export const updateProduct = async (
  id: product["product_id"],
  data: Omit<product, "product_id" | "removed" | "created_at" | "updated_on">
) => {
  return await prisma.product.update({
    where: { product_id: id },
    data,
  });
};

export const addProductVariants = async (variants: Omit<product_variants, "variant_id">[]) => {
  return prisma.$transaction(
    variants.map((variant) =>
      prisma.product_variants.create({
        data: variant,
      })
    )
  );
};

export const updateProductVariants = async (variants: product_variants[]) => {
  return prisma.$transaction(
    variants.map((variant) =>
      prisma.product_variants.update({
        where: { variant_id: variant.variant_id },
        data: variant,
      })
    )
  );
};

export const deleteProductVariant = async (variant_id: product_variants["product_id"]) => {
  return prisma.product_variants.delete({
    where: { variant_id },
  });
};

export const getProductWithCategory = async () => {
  return await prisma.product.findMany({
    include: {
      category: true,
    },
  });
};

export const getProductsBySupplierId = async (id: supplier["supplier_id"]) => {
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
