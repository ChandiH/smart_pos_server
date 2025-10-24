import prisma from "../config/prisma";
import { supplier } from "../prisma";

export const getSuppliers = async () => {
  return await prisma.supplier.findMany({
    include: {
      product: true,
    },
  });
};

export const getSupplier = async (id: string) => {
  return await prisma.supplier.findUnique({
    where: { supplier_id: Number(id) },
    include: {
      product: true,
    },
  });
};

export const addSupplier = async (data: Omit<supplier, "supplier_id">) => {
  return await prisma.supplier.create({
    data,
  });
};

export const updateSupplier = async (id: supplier["supplier_id"], data: Partial<Omit<supplier, "supplier_id">>) => {
  return await prisma.supplier.update({
    where: { supplier_id: Number(id) },
    data,
  });
};

export const isEmailTaken = async (email: string): Promise<number> => {
  const result = await prisma.supplier.count({
    where: { supplier_email: email },
  });
  return result;
};

export const isPhoneNumberExist = async (phone: string): Promise<number> => {
  const result = await prisma.supplier.count({
    where: { supplier_phone: phone },
  });
  return result;
};
