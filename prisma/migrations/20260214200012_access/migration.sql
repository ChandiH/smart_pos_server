/*
  Warnings:

  - You are about to drop the column `user_access` on the `user_role` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "user_role" DROP COLUMN "user_access";

-- CreateTable
CREATE TABLE "user_role_access" (
    "role_id" UUID NOT NULL,
    "access_type_id" UUID NOT NULL,

    CONSTRAINT "user_role_access_pkey" PRIMARY KEY ("role_id","access_type_id")
);

-- AddForeignKey
ALTER TABLE "user_role_access" ADD CONSTRAINT "fk_user_role_access_role" FOREIGN KEY ("role_id") REFERENCES "user_role"("role_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "user_role_access" ADD CONSTRAINT "fk_user_role_access_access" FOREIGN KEY ("access_type_id") REFERENCES "access_type"("access_type_id") ON DELETE CASCADE ON UPDATE NO ACTION;
