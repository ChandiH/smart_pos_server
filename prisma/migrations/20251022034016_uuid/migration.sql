-- AlterTable
CREATE SEQUENCE cart_cart_id_seq;
ALTER TABLE "cart" ALTER COLUMN "cart_id" SET DEFAULT nextval('cart_cart_id_seq');
ALTER SEQUENCE cart_cart_id_seq OWNED BY "cart"."cart_id";
