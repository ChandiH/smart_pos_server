-- AlterTable
CREATE SEQUENCE discount_discount_id_seq;
ALTER TABLE "discount" ALTER COLUMN "discount_id" SET DEFAULT nextval('discount_discount_id_seq');
ALTER SEQUENCE discount_discount_id_seq OWNED BY "discount"."discount_id";
