-- CreateTable
CREATE TABLE "access_type" (
    "access_type_id" SERIAL NOT NULL,
    "access_name" VARCHAR(100) NOT NULL,

    CONSTRAINT "access_type_pkey" PRIMARY KEY ("access_type_id")
);

-- CreateTable
CREATE TABLE "branch" (
    "branch_id" TEXT NOT NULL,
    "branch_city" VARCHAR(255) NOT NULL,
    "branch_address" VARCHAR(200) NOT NULL,
    "branch_phone" VARCHAR(13) NOT NULL,
    "branch_email" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "branch_pkey" PRIMARY KEY ("branch_id")
);

-- CreateTable
CREATE TABLE "cart" (
    "cart_id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "product_id" UUID NOT NULL,
    "quantity" INTEGER NOT NULL,
    "sub_total_amount" DECIMAL(1000,2),
    "created_at" DATE DEFAULT CURRENT_DATE,

    CONSTRAINT "cart_pkey" PRIMARY KEY ("cart_id")
);

-- CreateTable
CREATE TABLE "category" (
    "category_id" SERIAL NOT NULL,
    "category_name" VARCHAR(50) NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "customer" (
    "customer_id" SERIAL NOT NULL,
    "customer_name" VARCHAR(255) NOT NULL,
    "customer_email" VARCHAR(255),
    "customer_phone" VARCHAR(13) NOT NULL,
    "customer_address" VARCHAR(200),
    "visit_count" INTEGER DEFAULT 0,
    "rewards_points" DECIMAL(1000,2) DEFAULT 0.00,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "customer_pkey" PRIMARY KEY ("customer_id")
);

-- CreateTable
CREATE TABLE "discount" (
    "discount_id" SERIAL NOT NULL,
    "discount_name" VARCHAR(255) NOT NULL,
    "discount_desc" VARCHAR(200),
    "discount_percentage" DECIMAL(5,2) NOT NULL,

    CONSTRAINT "discount_pkey" PRIMARY KEY ("discount_id")
);

-- CreateTable
CREATE TABLE "employee" (
    "employee_id" SERIAL NOT NULL,
    "employee_name" VARCHAR(255) NOT NULL,
    "role_id" INTEGER NOT NULL,
    "hired_date" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "employee_email" VARCHAR(255),
    "employee_phone" VARCHAR(13) NOT NULL,
    "branch_id" TEXT NOT NULL,
    "employee_image" VARCHAR(255),
    "branch_updated_on" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "role_updated_on" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("employee_id")
);

-- CreateTable
CREATE TABLE "inventory" (
    "product_id" UUID NOT NULL,
    "branch_id" TEXT NOT NULL,
    "quantity" INTEGER,
    "reorder_level" INTEGER,
    "updated_on" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "inventory_pkey" PRIMARY KEY ("product_id","branch_id")
);

-- CreateTable
CREATE TABLE "payment_method" (
    "payment_method_id" SERIAL NOT NULL,
    "payment_method_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "payment_method_pkey" PRIMARY KEY ("payment_method_id")
);

-- CreateTable
CREATE TABLE "product" (
    "product_id" UUID NOT NULL,
    "product_name" VARCHAR(100) NOT NULL,
    "product_desc" VARCHAR(200),
    "category_id" INTEGER NOT NULL,
    "product_image" VARCHAR[],
    "buying_price" DECIMAL(1000,2) NOT NULL,
    "retail_price" DECIMAL(1000,2) NOT NULL,
    "discount" DECIMAL(1000,2),
    "supplier_id" INTEGER NOT NULL,
    "product_barcode" VARCHAR(255) NOT NULL,
    "removed" BOOLEAN DEFAULT false,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_pkey" PRIMARY KEY ("product_id")
);

-- CreateTable
CREATE TABLE "sales_history" (
    "order_id" SERIAL NOT NULL,
    "customer_id" INTEGER,
    "cashier_id" INTEGER NOT NULL,
    "branch_id" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "total_amount" DECIMAL(1000,2),
    "profit" DECIMAL(1000,2) DEFAULT 0.00,
    "rewards_points" DECIMAL(1000,2) DEFAULT 0.00,
    "payment_method_id" INTEGER,
    "reference_id" VARCHAR(255),
    "product_count" INTEGER,

    CONSTRAINT "sales_history_pkey" PRIMARY KEY ("order_id")
);

-- CreateTable
CREATE TABLE "supplier" (
    "supplier_id" SERIAL NOT NULL,
    "supplier_name" VARCHAR(200) NOT NULL,
    "supplier_email" VARCHAR(255),
    "supplier_phone" VARCHAR(13) NOT NULL,
    "supplier_address" VARCHAR(200) NOT NULL,

    CONSTRAINT "supplier_pkey" PRIMARY KEY ("supplier_id")
);

-- CreateTable
CREATE TABLE "user_credentials" (
    "user_id" INTEGER NOT NULL,
    "username" VARCHAR(30) NOT NULL,
    "password" VARCHAR(200) NOT NULL,
    "updated_on" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_credentials_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "user_role" (
    "role_id" SERIAL NOT NULL,
    "role_name" VARCHAR(100) NOT NULL,
    "role_desc" VARCHAR(200) NOT NULL,
    "user_access" INTEGER[],

    CONSTRAINT "user_role_pkey" PRIMARY KEY ("role_id")
);

-- CreateTable
CREATE TABLE "variable_options" (
    "variable_id" SERIAL NOT NULL,
    "variable_name" VARCHAR(100) NOT NULL,
    "created_at" TIMESTAMPTZ(0) DEFAULT CURRENT_TIMESTAMP,
    "variable_value" DECIMAL(1000,2),
    "updated_on" TIMESTAMPTZ(0) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "variable_options_pkey" PRIMARY KEY ("variable_id")
);

-- CreateTable
CREATE TABLE "working_hour" (
    "record_id" SERIAL NOT NULL,
    "employee_id" INTEGER NOT NULL,
    "date" VARCHAR(12) NOT NULL,
    "shift_on" VARCHAR(5) NOT NULL,
    "shift_off" VARCHAR(5) NOT NULL,
    "updated_by" INTEGER NOT NULL,
    "present" BOOLEAN NOT NULL,
    "total_hours" DECIMAL(100,2),

    CONSTRAINT "working_hour_pkey" PRIMARY KEY ("record_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "access_type_access_name_key" ON "access_type"("access_name");

-- CreateIndex
CREATE UNIQUE INDEX "branch_branch_city_key" ON "branch"("branch_city");

-- CreateIndex
CREATE UNIQUE INDEX "branch_branch_phone_key" ON "branch"("branch_phone");

-- CreateIndex
CREATE UNIQUE INDEX "branch_branch_email_key" ON "branch"("branch_email");

-- CreateIndex
CREATE UNIQUE INDEX "category_category_name_key" ON "category"("category_name");

-- CreateIndex
CREATE UNIQUE INDEX "customer_customer_email_key" ON "customer"("customer_email");

-- CreateIndex
CREATE UNIQUE INDEX "customer_customer_phone_key" ON "customer"("customer_phone");

-- CreateIndex
CREATE UNIQUE INDEX "discount_discount_name_key" ON "discount"("discount_name");

-- CreateIndex
CREATE UNIQUE INDEX "employee_employee_email_key" ON "employee"("employee_email");

-- CreateIndex
CREATE UNIQUE INDEX "employee_employee_phone_key" ON "employee"("employee_phone");

-- CreateIndex
CREATE UNIQUE INDEX "payment_method_payment_method_name_key" ON "payment_method"("payment_method_name");

-- CreateIndex
CREATE UNIQUE INDEX "product_product_name_key" ON "product"("product_name");

-- CreateIndex
CREATE UNIQUE INDEX "product_product_barcode_key" ON "product"("product_barcode");

-- CreateIndex
CREATE UNIQUE INDEX "supplier_supplier_email_key" ON "supplier"("supplier_email");

-- CreateIndex
CREATE UNIQUE INDEX "supplier_supplier_phone_key" ON "supplier"("supplier_phone");

-- CreateIndex
CREATE UNIQUE INDEX "user_credentials_username_key" ON "user_credentials"("username");

-- CreateIndex
CREATE UNIQUE INDEX "user_credentials_password_key" ON "user_credentials"("password");

-- CreateIndex
CREATE UNIQUE INDEX "user_role_role_name_key" ON "user_role"("role_name");

-- CreateIndex
CREATE UNIQUE INDEX "variable_options_variable_name_key" ON "variable_options"("variable_name");

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "fk_cart_product" FOREIGN KEY ("product_id") REFERENCES "product"("product_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "fk_cart_sales_history" FOREIGN KEY ("order_id") REFERENCES "sales_history"("order_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "fk_employee_branch" FOREIGN KEY ("branch_id") REFERENCES "branch"("branch_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "fk_employee_role" FOREIGN KEY ("role_id") REFERENCES "user_role"("role_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory" ADD CONSTRAINT "fk_inventory_branch" FOREIGN KEY ("branch_id") REFERENCES "branch"("branch_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "inventory" ADD CONSTRAINT "fk_inventory_product" FOREIGN KEY ("product_id") REFERENCES "product"("product_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "fk_product_category" FOREIGN KEY ("category_id") REFERENCES "category"("category_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "fk_supplier_id" FOREIGN KEY ("supplier_id") REFERENCES "supplier"("supplier_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales_history" ADD CONSTRAINT "fk_sales_history_branch" FOREIGN KEY ("branch_id") REFERENCES "branch"("branch_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales_history" ADD CONSTRAINT "fk_sales_history_customer" FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales_history" ADD CONSTRAINT "fk_sales_history_employee" FOREIGN KEY ("cashier_id") REFERENCES "employee"("employee_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales_history" ADD CONSTRAINT "fk_sales_history_payment_method" FOREIGN KEY ("payment_method_id") REFERENCES "payment_method"("payment_method_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "user_credentials" ADD CONSTRAINT "fk_user_credentials_employee" FOREIGN KEY ("user_id") REFERENCES "employee"("employee_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "working_hour" ADD CONSTRAINT "fk_employee_id" FOREIGN KEY ("employee_id") REFERENCES "employee"("employee_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "working_hour" ADD CONSTRAINT "fk_updated_by" FOREIGN KEY ("updated_by") REFERENCES "employee"("employee_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
