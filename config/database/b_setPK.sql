-- Trigger function for user_role table
CREATE OR REPLACE FUNCTION BeforeInsertUserRole()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM user_role) THEN
       NEW.role_id = 1;
   ELSE
       -- Find the maximum role_id value and increment it by 1
       SELECT MAX(role_id) + 1 INTO NEW.role_id FROM user_role;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM access_type) THEN
       NEW.access_type_id = 1;
   ELSE
       -- Find the maximum access_type_id value and increment it by 1
       SELECT MAX(access_type_id) + 1 INTO NEW.access_type_id FROM access_type;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM category) THEN
       NEW.category_id = 1;
   ELSE
       -- Find the maximum category_id value and increment it by 1
       SELECT MAX(category_id) + 1 INTO NEW.category_id FROM category;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM product) THEN
       NEW.product_id = 1;
   ELSE
       -- Find the maximum product_id value and increment it by 1
       SELECT MAX(product_id) + 1 INTO NEW.product_id FROM product;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM cart) THEN
       NEW.cart_id = 1;
   ELSE
       -- Find the maximum cart_id value and increment it by 1
       SELECT MAX(cart_id) + 1 INTO NEW.cart_id FROM cart;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM sales_history) THEN
       NEW.order_id = 1;
   ELSE
       -- Find the maximum order_id value and increment it by 1
       SELECT MAX(order_id) + 1 INTO NEW.order_id FROM sales_history;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM customer) THEN
       NEW.customer_id = 1;
   ELSE
       -- Find the maximum customer_id value and increment it by 1
       SELECT MAX(customer_id) + 1 INTO NEW.customer_id FROM customer;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM employee) THEN
       NEW.employee_id = 1;
   ELSE
       -- Find the maximum employee_id value and increment it by 1
       SELECT MAX(employee_id) + 1 INTO NEW.employee_id FROM employee;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM supplier) THEN
       NEW.supplier_id = 1;
   ELSE
       -- Find the maximum supplier_id value and increment it by 1
       SELECT MAX(supplier_id) + 1 INTO NEW.supplier_id FROM supplier;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM payment_method) THEN
       NEW.payment_method_id  = 1;
   ELSE
       -- Find the maximum id value and increment it by 1
       SELECT MAX(payment_method_id) + 1 INTO NEW.payment_method_id FROM payment_method;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM discount) THEN
       NEW.discount_id = 1;
   ELSE
       -- Find the maximum id value and increment it by 1
       SELECT MAX(discount_id) + 1 INTO NEW.discount_id FROM discount;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM branch) THEN
       NEW.branch_id = 1;
   ELSE
       -- Find the maximum id value and increment it by 1
       SELECT MAX(branch_id) + 1 INTO NEW.branch_id FROM branch;
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
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM variable_options) THEN
       NEW.variable_id = 1;
   ELSE
       -- Find the maximum id value and increment it by 1
        SELECT MAX(variable_id) + 1 INTO NEW.variable_id FROM variable_options;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for branch table
CREATE TRIGGER a_variable_options
BEFORE INSERT ON variable_options
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertVariable_options();

CREATE EXTENSION IF NOT EXISTS pgcrypto;


