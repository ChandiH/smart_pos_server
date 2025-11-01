/*
  Warnings:

  - You are about to drop the column `payment_method_id` on the `sales_history` table. All the data in the column will be lost.
  - You are about to drop the column `reference_id` on the `sales_history` table. All the data in the column will be lost.
  - You are about to drop the `payment_method` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."sales_history" DROP CONSTRAINT "fk_sales_history_payment_method";

-- AlterTable
ALTER TABLE "sales_history" DROP COLUMN "payment_method_id",
DROP COLUMN "reference_id",
ADD COLUMN     "payment_method" VARCHAR(20),
ADD COLUMN     "reference" VARCHAR(255);

-- DropTable
DROP TABLE "public"."payment_method";
