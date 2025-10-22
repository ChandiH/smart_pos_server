-- AlterTable
CREATE SEQUENCE variable_options_variable_id_seq;
ALTER TABLE "variable_options" ALTER COLUMN "variable_id" SET DEFAULT nextval('variable_options_variable_id_seq');
ALTER SEQUENCE variable_options_variable_id_seq OWNED BY "variable_options"."variable_id";
