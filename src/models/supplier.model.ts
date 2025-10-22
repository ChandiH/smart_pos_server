import prisma from "../config/prisma";

export const getSuppliers = async () => {
  return await prisma.supplier.findMany();
};

export const getSupplier = async (id: string) => {
  return await prisma.supplier.findUnique({
    where: { supplier_id: Number(id) },
  });
};

export const addSupplier = async (name: string, email: string, phone: string, address: string) => {
  return await prisma.supplier.create({
    data: {
      supplier_name: name,
      supplier_email: email,
      supplier_phone: phone,
      supplier_address: address,
    },
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
