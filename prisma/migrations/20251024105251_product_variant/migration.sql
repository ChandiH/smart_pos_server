/*
  Warnings:

  - The primary key for the `working_hour` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `record_id` on the `working_hour` table. All the data in the column will be lost.
  - Added the required column `branch_id` to the `working_hour` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "working_hour" DROP CONSTRAINT "working_hour_pkey",
DROP COLUMN "record_id",
ADD COLUMN     "branch_id" UUID NOT NULL,
ADD CONSTRAINT "working_hour_pkey" PRIMARY KEY ("employee_id", "branch_id", "date");

-- CreateTable
CREATE TABLE "product_variants" (
    "variant_id" UUID NOT NULL,
    "product_id" UUID NOT NULL,
    "buying_price" DECIMAL(1000,2) NOT NULL,
    "retail_price" DECIMAL(1000,2) NOT NULL,
    "discount" DECIMAL(1000,2),

    CONSTRAINT "product_variants_pkey" PRIMARY KEY ("variant_id")
);

-- AddForeignKey
ALTER TABLE "product_variants" ADD CONSTRAINT "fk_product_variants" FOREIGN KEY ("product_id") REFERENCES "product"("product_id") ON DELETE CASCADE ON UPDATE NO ACTION;
