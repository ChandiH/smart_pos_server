import prisma from "../config/prisma";
import { hashPassword } from "../utils/hash";

export type RegisterPayload = {
  employee_name: string;
  employee_userName: string;
  role_id: number;
  employee_email: string;
  employee_phone: string;
  branch_id: number;
  employee_image: string;
};

export const getUserCredentialsByUsername = async (username: string) => {
  return await prisma.user_credentials.findUnique({
    where: { username },
  });
};

export const register = async ({
  employee_name,
  employee_userName,
  role_id,
  employee_email,
  employee_phone,
  branch_id,
  employee_image,
}: RegisterPayload) => {
  return await prisma.$transaction(async (prisma) => {
    const employee = await prisma.employee.create({
      data: {
        employee_name,
        role_id,
        employee_email,
        employee_phone,
        branch_id: branch_id.toString(),
        employee_image,
      },
    });

    const hashedPassword = await hashPassword(employee_userName);

    await prisma.user_credentials.create({
      data: {
        user_id: employee.employee_id,
        username: employee_userName,
        password: hashedPassword, // Default password is the username
      },
    });

    return true;
  });
};

export const isUsernameTaken = async (username: string) => {
  return (
    (await prisma.user_credentials.count({
      where: { username },
    })) > 0
  );
};

export const resetPassword = async (user_id: number, password: string) => {
  const hashedPassword = await hashPassword(password);
  return await prisma.user_credentials.updateMany({
    where: { user_id },
    data: { password: hashedPassword },
  });
};

export const checkPassword = async (username: string, password: string) => {
  return await prisma.$queryRaw`SELECT 1 FROM user_credentials WHERE username = ${username} AND password = crypt(${password}, password) LIMIT 1`;
};
