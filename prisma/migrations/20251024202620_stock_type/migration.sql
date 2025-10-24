/*
  Warnings:

  - You are about to drop the column `buying_price` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `discount` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `retail_price` on the `product` table. All the data in the column will be lost.
  - Added the required column `stock_type` to the `product` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "product" DROP COLUMN "buying_price",
DROP COLUMN "discount",
DROP COLUMN "retail_price",
ADD COLUMN     "stock_type" VARCHAR(50) NOT NULL;
