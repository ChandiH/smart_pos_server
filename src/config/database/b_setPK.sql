-- Trigger function for user_role table
CREATE OR REPLACE FUNCTION BeforeInsertUserRole()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.role_id IS NULL THEN
       NEW.role_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for user_role table
CREATE TRIGGER a_user_role
BEFORE INSERT ON user_role
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertUserRole();


-- Trigger function for access_type table
CREATE OR REPLACE FUNCTION BeforeInsertAccessType()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.access_type_id IS NULL THEN
       NEW.access_type_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for access_type table
CREATE TRIGGER a_access_type
BEFORE INSERT ON access_type
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertAccessType();


-- Trigger function for category table
CREATE OR REPLACE FUNCTION BeforeInsertCategory()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.category_id IS NULL THEN
       NEW.category_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for category table
CREATE TRIGGER a_category
BEFORE INSERT ON category
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertCategory();



-- Trigger function for product table
CREATE OR REPLACE FUNCTION BeforeInsertProduct()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.product_id IS NULL THEN
       NEW.product_id := gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for product table
CREATE TRIGGER a_product
BEFORE INSERT ON product
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertProduct();



-- Trigger function for cart table
CREATE OR REPLACE FUNCTION BeforeInsertCart()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.cart_id IS NULL THEN
       NEW.cart_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for cart table
CREATE TRIGGER a_cart
BEFORE INSERT ON cart
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertCart();



-- Trigger function for sales_history table
CREATE OR REPLACE FUNCTION BeforeInsertSalesHistory()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.order_id IS NULL THEN
       NEW.order_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for sales_history table
CREATE TRIGGER a_sales_history
BEFORE INSERT ON sales_history
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertSalesHistory();



-- Trigger function for customer table
CREATE OR REPLACE FUNCTION BeforeInsertCustomer()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.customer_id IS NULL THEN
       NEW.customer_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for customer table
CREATE TRIGGER a_customer
BEFORE INSERT ON customer
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertCustomer();


-- Trigger function for employee table
CREATE OR REPLACE FUNCTION BeforeInsertEmployee()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.employee_id IS NULL THEN
       NEW.employee_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for employee table
CREATE TRIGGER a_employee
BEFORE INSERT ON employee
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertEmployee();


-- Trigger function for supplier table
CREATE OR REPLACE FUNCTION BeforeInsertSupplier()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.supplier_id IS NULL THEN
       NEW.supplier_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for supplier table
CREATE TRIGGER a_supplier
BEFORE INSERT ON supplier
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertSupplier();



-- Trigger function for payment_method table
CREATE OR REPLACE FUNCTION BeforeInsertPaymentMethod()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.payment_method_id IS NULL THEN
       NEW.payment_method_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for payment_method table
CREATE TRIGGER a_payment_method
BEFORE INSERT ON payment_method
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertPaymentMethod();




-- Trigger function for discount table
CREATE OR REPLACE FUNCTION BeforeInsertDiscount()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.discount_id IS NULL THEN
       NEW.discount_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for discount table
CREATE TRIGGER a_discount
BEFORE INSERT ON discount
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertDiscount();



-- Trigger function for branch table
CREATE OR REPLACE FUNCTION BeforeInsertBranch()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.branch_id IS NULL THEN
       NEW.branch_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for branch table
CREATE TRIGGER a_branch
BEFORE INSERT ON branch
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertBranch();

-- Trigger function for variable_options table
CREATE OR REPLACE FUNCTION BeforeInsertVariable_options()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.variable_id IS NULL THEN
       NEW.variable_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for branch table
CREATE TRIGGER a_variable_options
BEFORE INSERT ON variable_options
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertVariable_options();

-- Trigger function for working hour table
CREATE OR REPLACE FUNCTION BeforeInsertWorking_hour()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.record_id IS NULL THEN
       NEW.record_id = gen_random_uuid();
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for branch table
CREATE TRIGGER a_working_hour
BEFORE INSERT ON working_hour
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertWorking_hour();

CREATE EXTENSION IF NOT EXISTS pgcrypto;

