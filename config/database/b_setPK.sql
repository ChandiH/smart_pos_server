-- Trigger function for user_role table
CREATE OR REPLACE FUNCTION BeforeInsertUserRole()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM user_role) THEN
       NEW.role_ID = 1;
   ELSE
       -- Find the maximum role_ID value and increment it by 1
       SELECT MAX(role_ID) + 1 INTO NEW.role_ID FROM user_role;
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
       NEW.access_type_ID = 1;
   ELSE
       -- Find the maximum access_type_ID value and increment it by 1
       SELECT MAX(access_type_ID) + 1 INTO NEW.access_type_ID FROM access_type;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for access_type table
CREATE TRIGGER a_access_type
BEFORE INSERT ON access_type
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertAccessType();


-- Trigger function for user_access table
CREATE OR REPLACE FUNCTION BeforeInsertUserAccess()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM user_access) THEN
       NEW.user_access_ID = 1;
   ELSE
       -- Find the maximum user_access_ID value and increment it by 1
       SELECT MAX(user_access_ID) + 1 INTO NEW.user_access_ID FROM user_access;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for user_access table
CREATE TRIGGER a_user_access
BEFORE INSERT ON user_access
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertUserAccess();




-- Trigger function for category table
CREATE OR REPLACE FUNCTION BeforeInsertCategory()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM category) THEN
       NEW.category_ID = 1;
   ELSE
       -- Find the maximum category_ID value and increment it by 1
       SELECT MAX(category_ID) + 1 INTO NEW.category_ID FROM category;
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
       NEW.product_ID = 1;
   ELSE
       -- Find the maximum product_ID value and increment it by 1
       SELECT MAX(product_ID) + 1 INTO NEW.product_ID FROM product;
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
       NEW.cart_ID = 1;
   ELSE
       -- Find the maximum cart_ID value and increment it by 1
       SELECT MAX(cart_ID) + 1 INTO NEW.cart_ID FROM cart;
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
       NEW.transaction_number = 1;
   ELSE
       -- Find the maximum transaction_number value and increment it by 1
       SELECT MAX(transaction_number) + 1 INTO NEW.transaction_number FROM sales_history;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for sales_history table
CREATE TRIGGER a_sales_history
BEFORE INSERT ON sales_history
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertSalesHistory();



-- Trigger function for units_of_measure table
CREATE OR REPLACE FUNCTION BeforeInsertUnitsOfMeasure()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM units_of_measure) THEN
       NEW.uom_ID = 1;
   ELSE
       -- Find the maximum uom_ID value and increment it by 1
       SELECT MAX(uom_ID) + 1 INTO NEW.uom_ID FROM units_of_measure;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for units_of_measure table
CREATE TRIGGER a_units_of_measure
BEFORE INSERT ON units_of_measure
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertUnitsOfMeasure();



-- Trigger function for customer table
CREATE OR REPLACE FUNCTION BeforeInsertCustomer()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM customer) THEN
       NEW.customer_ID = 1;
   ELSE
       -- Find the maximum customer_ID value and increment it by 1
       SELECT MAX(customer_ID) + 1 INTO NEW.customer_ID FROM customer;
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
       NEW.employee_ID = 1;
   ELSE
       -- Find the maximum employee_ID value and increment it by 1
       SELECT MAX(employee_ID) + 1 INTO NEW.employee_ID FROM employee;
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
       NEW.supplier_ID = 1;
   ELSE
       -- Find the maximum supplier_ID value and increment it by 1
       SELECT MAX(supplier_ID) + 1 INTO NEW.supplier_ID FROM supplier;
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
       NEW.ID = 1;
   ELSE
       -- Find the maximum ID value and increment it by 1
       SELECT MAX(ID) + 1 INTO NEW.ID FROM payment_method;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for payment_method table
CREATE TRIGGER a_payment_method
BEFORE INSERT ON payment_method
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertPaymentMethod();




-- Trigger function for discounts_and_promotions table
CREATE OR REPLACE FUNCTION BeforeInsertDiscountsAndPromotions()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM discounts_and_promotions) THEN
       NEW.ID = 1;
   ELSE
       -- Find the maximum ID value and increment it by 1
       SELECT MAX(ID) + 1 INTO NEW.ID FROM discounts_and_promotions;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for discounts_and_promotions table
CREATE TRIGGER a_discounts_and_promotions
BEFORE INSERT ON discounts_and_promotions
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertDiscountsAndPromotions();



-- Trigger function for gift_cards table
CREATE OR REPLACE FUNCTION BeforeInsertGiftCards()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM gift_cards) THEN
       NEW.card_number = 1;
   ELSE
       -- Find the maximum card_number value and increment it by 1
       SELECT MAX(card_number) + 1 INTO NEW.card_number FROM gift_cards;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for gift_cards table
CREATE TRIGGER a_gift_cards
BEFORE INSERT ON gift_cards
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertGiftCards();



-- Trigger function for branch table
CREATE OR REPLACE FUNCTION BeforeInsertBranch()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if the table is empty
   IF NOT EXISTS (SELECT 1 FROM branch) THEN
       NEW.ID = 1;
   ELSE
       -- Find the maximum ID value and increment it by 1
       SELECT MAX(ID) + 1 INTO NEW.ID FROM branch;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for branch table
CREATE TRIGGER a_branch
BEFORE INSERT ON branch
FOR EACH ROW
EXECUTE FUNCTION BeforeInsertBranch();



