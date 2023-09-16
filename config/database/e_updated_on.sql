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


CREATE OR REPLACE FUNCTION update_employee_updated_on()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER z_employee_update_trigger
BEFORE UPDATE  ON employee
FOR EACH ROW
EXECUTE FUNCTION update_employee_updated_on();