import prisma from "../config/prisma";

export const getUserRoles = async () => {
  return await prisma.user_role.findMany();
};

export const getUserRole = async (role_id: string) => {
  return await prisma.user_role.findUnique({
    where: { role_id: Number(role_id) },
  });
};

export const getAccessList = async () => {
  return await prisma.access_type.findMany();
};

export const getAccessEnum = async (access_name: string) => {
  return await prisma.access_type.findUnique({
    where: { access_name },
  });
};

export const updateUserAccess = async (role_id: number, access: number[]) => {
  return await prisma.user_role.update({
    where: { role_id },
    data: { user_access: access },
  });
};

export const addUserRole = async (role_name: string, role_desc: string, user_access: number[]) => {
  return await prisma.user_role.create({
    data: {
      role_name,
      role_desc,
      user_access,
    },
  });
};

export const deleteUserRole = async (role_id: string) => {
  return await prisma.user_role.delete({
    where: { role_id: Number(role_id) },
  });
};
