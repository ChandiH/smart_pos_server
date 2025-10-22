-- AlterTable
CREATE SEQUENCE employee_employee_id_seq;
ALTER TABLE "employee" ALTER COLUMN "employee_id" SET DEFAULT nextval('employee_employee_id_seq');
ALTER SEQUENCE employee_employee_id_seq OWNED BY "employee"."employee_id";
