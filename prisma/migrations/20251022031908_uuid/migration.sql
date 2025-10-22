-- AlterTable
CREATE SEQUENCE payment_method_payment_method_id_seq;
ALTER TABLE "payment_method" ALTER COLUMN "payment_method_id" SET DEFAULT nextval('payment_method_payment_method_id_seq');
ALTER SEQUENCE payment_method_payment_method_id_seq OWNED BY "payment_method"."payment_method_id";
