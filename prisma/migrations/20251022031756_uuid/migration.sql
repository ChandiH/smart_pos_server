-- AlterTable
CREATE SEQUENCE access_type_access_type_id_seq;
ALTER TABLE "access_type" ALTER COLUMN "access_type_id" SET DEFAULT nextval('access_type_access_type_id_seq');
ALTER SEQUENCE access_type_access_type_id_seq OWNED BY "access_type"."access_type_id";
