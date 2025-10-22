-- AlterTable
CREATE SEQUENCE user_role_role_id_seq;
ALTER TABLE "user_role" ALTER COLUMN "role_id" SET DEFAULT nextval('user_role_role_id_seq');
ALTER SEQUENCE user_role_role_id_seq OWNED BY "user_role"."role_id";
