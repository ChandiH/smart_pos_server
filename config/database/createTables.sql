-- Create Tables

-- User roles
CREATE TABLE user_role (
    role_ID INTEGER PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    role_desc VARCHAR(200) NOT NULL
);

-- Access type
CREATE TABLE access_type (
    access_type_ID INTEGER PRIMARY KEY,
    access_name VARCHAR(100) NOT NULL
);

-- User access
CREATE TABLE user_access (
    user_access_ID INTEGER PRIMARY KEY,
    role_ID INTEGER NOT NULL,
    access_type_ID INTEGER NOT NULL
);

-- Category
CREATE TABLE category (
    category_ID INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Products
CREATE TABLE product (
    product_ID INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    products_desc VARCHAR(200),
    category_ID INTEGER ,
    product_image VARCHAR(200),
    measure_of_unit_id INTEGER NOT NULL,
    buying_ppu NUMERIC(1000, 2),
    retail_ppu NUMERIC(1000, 2),
    supplier_ID INTEGER ,
    barcode VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL,
    created_on DATE,
    updated_on DATE
);

-- Inventory
CREATE TABLE inventory (
    
    product_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    quantity INTEGER,
    updated_on DATE,
    reorder_level INTEGER,
     PRIMARY KEY(product_id, branch_id)
);

-- Cart
CREATE TABLE cart (
    cart_ID INTEGER PRIMARY KEY,
    transaction_number VARCHAR(255),
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    discount_percentage NUMERIC(5,2),
    discount NUMERIC(1000, 2),
    total_amount NUMERIC(1000, 2),
    date DATE,
    status VARCHAR(10) DEFAULT 'pending'
);

-- Orders
CREATE TABLE sales_history (
    transaction_number VARCHAR(255) PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    cashier_id INTEGER NOT NULL,
    datetime TIMESTAMP,
    total_payment NUMERIC(1000,2),
    payment_method_id INTEGER NOT NULL
);

-- Units of measure
CREATE TABLE units_of_measure (
    uom_ID INTEGER PRIMARY KEY,
    uom_name VARCHAR(60) NOT NULL,
    abbreviations VARCHAR(30) NOT NULL
);

-- Customer
CREATE TABLE customer (
    customer_ID INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(13) NOT NULL,
    address VARCHAR(200),
    visit_count INTEGER,
    rewards_points NUMERIC(1000, 2)
);

-- Employee
CREATE TABLE employee (
    employee_ID INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(200) NOT NULL, 
    role_id INTEGER NOT NULL,
    hired_date DATE,
    email VARCHAR(255),
    phone VARCHAR(13) NOT NULL,
    branch_id INTEGER NOT NULL,
    updated_on DATE
);

-- Suppliers
CREATE TABLE supplier (
    supplier_ID INTEGER PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(255),
   phone VARCHAR(13) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- Payment method
CREATE TABLE payment_method (
    ID INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Discounts and promotions
CREATE TABLE discounts_and_promotions (
    ID INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(200),
    discount_percentage NUMERIC(5, 2) NOT NULL
);

-- Gift cards
CREATE TABLE gift_cards (
    card_number VARCHAR(255) PRIMARY KEY,
    card_value NUMERIC(1000, 2),
    expired_date DATE
);

-- Branch
CREATE TABLE branch (
    ID INTEGER PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(13) NOT NULL,
    email VARCHAR(255) NOT NULL
);

--add constraints
ALTER TABLE user_access
    ADD CONSTRAINT fk_role_ID
	FOREIGN KEY (role_ID)
	REFERENCES user_role (role_ID) 
	ON DELETE CASCADE;
ALTER TABLE user_access
    ADD CONSTRAINT fk_access_type_ID
	FOREIGN KEY (access_type_ID) 
	REFERENCES access_type (access_type_ID)
	ON DELETE CASCADE;
	
ALTER TABLE product
	ADD CONSTRAINT fk_product_category
	FOREIGN KEY (category_ID) 
	REFERENCES category (category_ID)
	ON DELETE CASCADE;
ALTER TABLE product
	ADD CONSTRAINT fk_supplier_ID 
	FOREIGN KEY (supplier_ID)
	REFERENCES supplier (supplier_ID);
ALTER TABLE product
	ADD CONSTRAINT fk_product_measure
	FOREIGN KEY (measure_of_unit_id) 
	REFERENCES units_of_measure(uom_ID)  ;

ALTER TABLE inventory 
	ADD CONSTRAINT fk_inventory_product
	FOREIGN KEY (product_id)
	REFERENCES product (product_ID)
	ON DELETE CASCADE;
ALTER TABLE inventory
	ADD CONSTRAINT fk_inventory_branch
	FOREIGN KEY (branch_id) 
	REFERENCES branch (ID)
	ON DELETE CASCADE;

ALTER TABLE cart
	ADD CONSTRAINT fk_cart_product	
	FOREIGN KEY (product_id) 
	REFERENCES product (product_ID) 
	ON DELETE CASCADE;
ALTER TABLE cart
	ADD CONSTRAINT fk_transaction_number 
	FOREIGN KEY (transaction_number) 
	REFERENCES sales_history (transaction_number)
	ON DELETE CASCADE;

ALTER TABLE sales_history
	ADD CONSTRAINT fk_sales_history_customer
	FOREIGN KEY (customer_id) 
	REFERENCES customer (customer_ID)
	ON DELETE CASCADE;
ALTER TABLE sales_history
	ADD CONSTRAINT fk_sales_history_employee 
	FOREIGN KEY (cashier_id) 
	REFERENCES employee (employee_ID) 
	ON DELETE CASCADE;
ALTER TABLE sales_history 
	ADD CONSTRAINT fk_sales_history_payment_method
	FOREIGN KEY (payment_method_id)
	REFERENCES payment_method (ID) 
	ON DELETE CASCADE;

ALTER TABLE employee
	ADD CONSTRAINT fk_employee_role
	FOREIGN KEY (role_id)
	REFERENCES user_role (role_ID);

ALTER TABLE employee
	ADD CONSTRAINT fk_employee_branch
	FOREIGN KEY (branch_id)
	REFERENCES branch (ID);






