CREATE OR REPLACE FUNCTION update_product_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER z_product_update_trigger
BEFORE UPDATE  ON product
FOR EACH ROW
EXECUTE FUNCTION update_product_updated_on();


CREATE OR REPLACE FUNCTION update_inventory_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER z_inventory_update_trigger
BEFORE UPDATE  ON inventory 
FOR EACH ROW
EXECUTE FUNCTION update_inventory_updated_on();


CREATE OR REPLACE FUNCTION update_user_credentials_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER z_user_credentials_update_trigger
BEFORE UPDATE  ON user_credentials
FOR EACH ROW
EXECUTE FUNCTION update_user_credentials_updated_on();


-- Create a trigger function
CREATE OR REPLACE FUNCTION update_role_branch_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.role_id <> OLD.role_id THEN
        NEW.role_updated_on = CURRENT_timestamp;
    END IF;

    IF NEW.branch_id <> OLD.branch_id THEN
        NEW.branch_updated_on = CURRENT_timestamp;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger on the employee table
CREATE TRIGGER Z_employee_update_trigger
BEFORE UPDATE ON employee
FOR EACH ROW
EXECUTE FUNCTION update_role_branch_updated_on();


CREATE OR REPLACE FUNCTION update_variable_options_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER z_variable_options_update_trigger
BEFORE UPDATE  ON variable_options
FOR EACH ROW
EXECUTE FUNCTION update_variable_options_updated_on();
