/*
  Warnings:

  - The primary key for the `access_type` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `cart` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `order_id` column on the `cart` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `category` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `customer` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `discount` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `employee` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `sales_history` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `customer_id` column on the `sales_history` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `supplier` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `user_credentials` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `user_role` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `user_access` column on the `user_role` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `variable_options` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `working_hour` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `access_type_id` on the `access_type` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `cart_id` on the `cart` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `category_id` on the `category` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `customer_id` on the `customer` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `discount_id` on the `discount` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `employee_id` on the `employee` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `role_id` on the `employee` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `category_id` on the `product` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `supplier_id` on the `product` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `order_id` on the `sales_history` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `cashier_id` on the `sales_history` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `supplier_id` on the `supplier` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `user_id` on the `user_credentials` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `role_id` on the `user_role` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `variable_id` on the `variable_options` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `employee_id` on the `working_hour` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `updated_by` on the `working_hour` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "public"."cart" DROP CONSTRAINT "fk_cart_sales_history";

-- DropForeignKey
ALTER TABLE "public"."employee" DROP CONSTRAINT "fk_employee_role";

-- DropForeignKey
ALTER TABLE "public"."product" DROP CONSTRAINT "fk_product_category";

-- DropForeignKey
ALTER TABLE "public"."product" DROP CONSTRAINT "fk_supplier_id";

-- DropForeignKey
ALTER TABLE "public"."sales_history" DROP CONSTRAINT "fk_sales_history_customer";

-- DropForeignKey
ALTER TABLE "public"."sales_history" DROP CONSTRAINT "fk_sales_history_employee";

-- DropForeignKey
ALTER TABLE "public"."user_credentials" DROP CONSTRAINT "fk_user_credentials_employee";

-- DropForeignKey
ALTER TABLE "public"."working_hour" DROP CONSTRAINT "fk_employee_id";

-- DropForeignKey
ALTER TABLE "public"."working_hour" DROP CONSTRAINT "fk_updated_by";

-- AlterTable
ALTER TABLE "access_type" DROP CONSTRAINT "access_type_pkey",
DROP COLUMN "access_type_id",
ADD COLUMN     "access_type_id" UUID NOT NULL,
ADD CONSTRAINT "access_type_pkey" PRIMARY KEY ("access_type_id");

-- AlterTable
ALTER TABLE "cart" DROP CONSTRAINT "cart_pkey",
DROP COLUMN "cart_id",
ADD COLUMN     "cart_id" UUID NOT NULL,
DROP COLUMN "order_id",
ADD COLUMN     "order_id" UUID,
ADD CONSTRAINT "cart_pkey" PRIMARY KEY ("cart_id");

-- AlterTable
ALTER TABLE "category" DROP CONSTRAINT "category_pkey",
DROP COLUMN "category_id",
ADD COLUMN     "category_id" UUID NOT NULL,
ADD CONSTRAINT "category_pkey" PRIMARY KEY ("category_id");

-- AlterTable
ALTER TABLE "customer" DROP CONSTRAINT "customer_pkey",
DROP COLUMN "customer_id",
ADD COLUMN     "customer_id" UUID NOT NULL,
ADD CONSTRAINT "customer_pkey" PRIMARY KEY ("customer_id");

-- AlterTable
ALTER TABLE "discount" DROP CONSTRAINT "discount_pkey",
DROP COLUMN "discount_id",
ADD COLUMN     "discount_id" UUID NOT NULL,
ADD CONSTRAINT "discount_pkey" PRIMARY KEY ("discount_id");

-- AlterTable
ALTER TABLE "employee" DROP CONSTRAINT "employee_pkey",
DROP COLUMN "employee_id",
ADD COLUMN     "employee_id" UUID NOT NULL,
DROP COLUMN "role_id",
ADD COLUMN     "role_id" UUID NOT NULL,
ADD CONSTRAINT "employee_pkey" PRIMARY KEY ("employee_id");

-- AlterTable
ALTER TABLE "product" DROP COLUMN "category_id",
ADD COLUMN     "category_id" UUID NOT NULL,
DROP COLUMN "supplier_id",
ADD COLUMN     "supplier_id" UUID NOT NULL;

-- AlterTable
ALTER TABLE "sales_history" DROP CONSTRAINT "sales_history_pkey",
DROP COLUMN "order_id",
ADD COLUMN     "order_id" UUID NOT NULL,
DROP COLUMN "customer_id",
ADD COLUMN     "customer_id" UUID,
DROP COLUMN "cashier_id",
ADD COLUMN     "cashier_id" UUID NOT NULL,
ADD CONSTRAINT "sales_history_pkey" PRIMARY KEY ("order_id");

-- AlterTable
ALTER TABLE "supplier" DROP CONSTRAINT "supplier_pkey",
DROP COLUMN "supplier_id",
ADD COLUMN     "supplier_id" UUID NOT NULL,
ADD CONSTRAINT "supplier_pkey" PRIMARY KEY ("supplier_id");

-- AlterTable
ALTER TABLE "user_credentials" DROP CONSTRAINT "user_credentials_pkey",
DROP COLUMN "user_id",
ADD COLUMN     "user_id" UUID NOT NULL,
ADD CONSTRAINT "user_credentials_pkey" PRIMARY KEY ("user_id");

-- AlterTable
ALTER TABLE "user_role" DROP CONSTRAINT "user_role_pkey",
DROP COLUMN "role_id",
ADD COLUMN     "role_id" UUID NOT NULL,
DROP COLUMN "user_access",
ADD COLUMN     "user_access" UUID[],
ADD CONSTRAINT "user_role_pkey" PRIMARY KEY ("role_id");

-- AlterTable
ALTER TABLE "variable_options" DROP CONSTRAINT "variable_options_pkey",
DROP COLUMN "variable_id",
ADD COLUMN     "variable_id" UUID NOT NULL,
ADD CONSTRAINT "variable_options_pkey" PRIMARY KEY ("variable_id");

-- AlterTable
ALTER TABLE "working_hour" DROP CONSTRAINT "working_hour_pkey",
DROP COLUMN "employee_id",
ADD COLUMN     "employee_id" UUID NOT NULL,
DROP COLUMN "updated_by",
ADD COLUMN     "updated_by" UUID NOT NULL,
ADD CONSTRAINT "working_hour_pkey" PRIMARY KEY ("employee_id", "branch_id", "date");

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "fk_cart_sales_history" FOREIGN KEY ("order_id") REFERENCES "sales_history"("order_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "fk_employee_role" FOREIGN KEY ("role_id") REFERENCES "user_role"("role_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "fk_product_category" FOREIGN KEY ("category_id") REFERENCES "category"("category_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "fk_supplier_id" FOREIGN KEY ("supplier_id") REFERENCES "supplier"("supplier_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales_history" ADD CONSTRAINT "fk_sales_history_customer" FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales_history" ADD CONSTRAINT "fk_sales_history_employee" FOREIGN KEY ("cashier_id") REFERENCES "employee"("employee_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "user_credentials" ADD CONSTRAINT "fk_user_credentials_employee" FOREIGN KEY ("user_id") REFERENCES "employee"("employee_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "working_hour" ADD CONSTRAINT "fk_employee_id" FOREIGN KEY ("employee_id") REFERENCES "employee"("employee_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "working_hour" ADD CONSTRAINT "fk_updated_by" FOREIGN KEY ("updated_by") REFERENCES "employee"("employee_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
