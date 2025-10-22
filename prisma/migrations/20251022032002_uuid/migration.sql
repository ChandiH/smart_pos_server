-- AlterTable
CREATE SEQUENCE supplier_supplier_id_seq;
ALTER TABLE "supplier" ALTER COLUMN "supplier_id" SET DEFAULT nextval('supplier_supplier_id_seq');
ALTER SEQUENCE supplier_supplier_id_seq OWNED BY "supplier"."supplier_id";
