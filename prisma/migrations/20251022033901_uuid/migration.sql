-- AlterTable
CREATE SEQUENCE sales_history_order_id_seq;
ALTER TABLE "sales_history" ALTER COLUMN "order_id" SET DEFAULT nextval('sales_history_order_id_seq');
ALTER SEQUENCE sales_history_order_id_seq OWNED BY "sales_history"."order_id";
