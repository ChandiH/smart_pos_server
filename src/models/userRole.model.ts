import type { Prisma } from "@prisma/client";
import prisma from "../config/prisma";

const resolveAccessTypeIds = async (tx: Prisma.TransactionClient, access: string[]) => {
  const accessNames = [...new Set(access)];

  if (!accessNames.length) {
    return [];
  }

  const accessTypes = await tx.access_type.findMany({
    where: {
      access_name: { in: accessNames },
    },
    select: {
      access_type_id: true,
      access_name: true,
    },
  });

  if (accessTypes.length !== accessNames.length) {
    const found = new Set(accessTypes.map((entry) => entry.access_name));
    const missing = accessNames.filter((name) => !found.has(name));
    throw new Error(`Unknown access rules: ${missing.join(", ")}`);
  }

  return accessTypes.map((entry) => entry.access_type_id);
};

export const getUserRoles = async () => {
  const roles = await prisma.user_role.findMany({
    include: {
      user_role_access: {
        select: {
          access_type: {
            select: {
              access_name: true,
            },
          }
        },
      },
    },
  });

  return roles.map((role) => ({
    ...role,
    user_access: role.user_role_access.map((access) => access.access_type.access_name),
  }));
};

export const getUserRole = async (role_id: string) => {
  const role = await prisma.user_role.findUnique({
    where: { role_id },
    include: {
      user_role_access: {
        select: {
          access_type: {
            select: {
              access_name: true,
            },
          },
        },
      },
    },
  });

  if (!role) {
    return null;
  }

  return {
    ...role,
    user_access: role.user_role_access.map((access) => access.access_type.access_name),
  };
};

export const getAccessList = async () => {
  return await prisma.access_type.findMany();
};

export const getAccessEnum = async (access_name: string) => {
  return await prisma.access_type.findUnique({
    where: { access_name },
  });
};

export const updateUserAccess = async (role_id: string, access: string[]) => {
  return await prisma.$transaction(async (tx) => {
    const accessTypeIds = await resolveAccessTypeIds(tx, access);

    await tx.user_role_access.deleteMany({ where: { role_id } });

    if (accessTypeIds.length) {
      await tx.user_role_access.createMany({
        data: accessTypeIds.map((access_type_id) => ({
          role_id,
          access_type_id,
        })),
        skipDuplicates: true,
      });
    }

    const role = await tx.user_role.findUnique({
      where: { role_id },
      include: {
        user_role_access: {
          select: {
            access_type: {
              select: {
                access_name: true,
              },
            },
          },
        },
      },
    });

    if (!role) {
      return null;
    }

    return {
      ...role,
      user_access: role.user_role_access.map((entry) => entry.access_type.access_name),
    };
  });
};

export const addUserRole = async (role_name: string, role_desc: string, user_access: string[]) => {
  return await prisma.$transaction(async (tx) => {
    const accessTypeIds = await resolveAccessTypeIds(tx, user_access);
    const role = await tx.user_role.create({
      data: {
        role_name,
        role_desc,
      },
    });

    if (accessTypeIds.length) {
      await tx.user_role_access.createMany({
        data: accessTypeIds.map((access_type_id) => ({
          role_id: role.role_id,
          access_type_id,
        })),
        skipDuplicates: true,
      });
    }

    return role;
  });
};

export const deleteUserRole = async (role_id: string) => {
  return await prisma.user_role.delete({
    where: { role_id },
  });
};
