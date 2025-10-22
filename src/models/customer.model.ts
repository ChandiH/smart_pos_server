import prisma from "../config/prisma";

export const getCustomers = () => {
  return prisma.customer.findMany();
};

export const getCustomer = (id: string) => {
  return prisma.customer.findUnique({
    where: { customer_id: Number(id) },
  });
};

export const addCustomer = (
  customer_name: string,
  customer_email: string,
  customer_phone: string,
  customer_address: string
) => {
  return prisma.customer.create({
    data: {
      customer_name,
      customer_email,
      customer_phone,
      customer_address,
    },
  });
};

export const updateCustomer = (
  id: string,
  customer_name: string,
  customer_email: string,
  customer_phone: string,
  customer_address: string
) => {
  return prisma.customer.update({
    where: { customer_id: Number(id) },
    data: {
      customer_name,
      customer_email,
      customer_phone,
      customer_address,
    },
  });
};
