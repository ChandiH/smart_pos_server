-- Create Tables

-- User roles
CREATE TABLE user_role (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL UNIQUE,
    role_desc VARCHAR(200) NOT NULL
);

-- Access type
CREATE TABLE access_type (
    access_type_id INTEGER PRIMARY KEY,
    access_name VARCHAR(100) NOT NULL UNIQUE
);

-- User access
CREATE TABLE user_access (
    user_access__id INTEGER  PRIMARY KEY,
    role_id INTEGER NOT NULL,
    access_type_id INTEGER NOT NULL
);

-- Category
CREATE TABLE category (
    category_id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Products
CREATE TABLE product (
    product_id INTEGER  PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(200),
    category_id INTEGER ,
    image VARCHAR(200), -- array
    --unit_id INTEGER NOT NULL,
    buying_ppu NUMERIC(1000, 2),
    retail_ppu NUMERIC(1000, 2),
    discount NUMERIC(1000, 2),
    supplier_id INTEGER ,
    barcode VARCHAR(255) NOT NULL UNIQUE,
    -- quantity INTEGER NOT NULL,
    created_on DATE DEFAULT CURRENT_DATE,
    updated_on DATE DEFAULT '1000-01-01' -- trigger for updated date
);

-- Inventory
CREATE TABLE inventory (
    product_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    quantity INTEGER,
    lastUpdate_at DATE,
    reorder_level INTEGER,
    PRIMARY KEY(product_id, branch_id)
);

-- Cart
CREATE TABLE cart (
    cart_id INTEGER  PRIMARY KEY,
    transaction_number INTEGER ,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    --discount_percentage NUMERIC(5,2),
    --discount NUMERIC(1000, 2),
    total_amount NUMERIC(1000, 2),
    date DATE DEFAULT current_date,
    --status VARCHAR(10) DEFAULT 'pending'
);

-- Orders
CREATE TABLE sales_history (
    transaction_number INTEGER  PRIMARY KEY,
    customer_id INTEGER NOT NULL DEFAULT 1,
    cashier_id INTEGER NOT NULL,
    datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_payment NUMERIC(1000,2) DEFAULT 0.00,
    payment_method_id INTEGER NOT NULL DEFAULT 1,
    --profit NUMERIC(1000,2) DEFAULT 0.00,
    -- do we need to add discount type in a field?

    --status VARCHAR(10) DEFAULT 'not p_id'
);

-- Units of measure
/*
CREATE TABLE units_of_measure (
    uom_id INTEGER  PRIMARY KEY,
    uom_name VARCHAR(60) NOT NULL UNIQUE,
    abbreviations VARCHAR(30) NOT NULL
);*/

-- Customer
CREATE TABLE customer (
    customer_id INTEGER  PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(13) NOT NULL UNIQUE,
    address VARCHAR(200),
    visit_count INTEGER,
    rewards_points NUMERIC(1000, 2)
);

-- Employee
CREATE TABLE employee (
    employee_id INTEGER  PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE, --add into different table
    password VARCHAR(200) NOT NULL UNIQUE, --add into different table
    role_id INTEGER NOT NULL,
    hired_date DATE DEFAULT CURRENT_DATE,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(13) NOT NULL ,
    branch_id INTEGER NOT NULL,
    updated_on DATE DEFAULT '1000-01-01'
);

-- Suppliers
CREATE TABLE supplier (
    supplier_id INTEGER  PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(255),
   phone VARCHAR(13) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- Payment method
CREATE TABLE payment_method (
_id INTEGER  PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Discounts and promotions
CREATE TABLE discounts_and_promotions (
_id INTEGER  PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(200),
    discount_percentage NUMERIC(5, 2) NOT NULL
);

/*
-- Gift cards
CREATE TABLE gift_cards (
    card_number INTEGER  PRIMARY KEY,
    card_value NUMERIC(1000, 2),
    expired_date DATE,
    barcode VARCHAR(255) NOT NULL UNIQUE);*/

-- Branch
CREATE TABLE branch (
_id INTEGER  PRIMARY KEY,
    city VARCHAR(255) NOT NULL ,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(13) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE
);

--add constraints
ALTER TABLE user_access
    ADD CONSTRAINT fk_role_id
	FOREIGN KEY (role_id)
	REFERENCES user_role (role_id) 
	ON DELETE CASCADE;
ALTER TABLE user_access
    ADD CONSTRAINT fk_access_type_id
	FOREIGN KEY (access_type_id) 
	REFERENCES access_type (access_type_id)
	ON DELETE CASCADE;
	
ALTER TABLE product
	ADD CONSTRAINT fk_product_category
	FOREIGN KEY (category_id) 
	REFERENCES category (category_id)
	ON DELETE CASCADE;
ALTER TABLE product
	ADD CONSTRAINT fk_supplier_id 
	FOREIGN KEY (supplier_id)
	REFERENCES supplier (supplier_id);
    /*
ALTER TABLE product
	ADD CONSTRAINT fk_product_measure
	FOREIGN KEY (unit_id) 
	REFERENCES units_of_measure(uom_id)  ;
*/
ALTER TABLE inventory 
	ADD CONSTRAINT fk_inventory_product
	FOREIGN KEY (product_id)
	REFERENCES product (product_id)
	ON DELETE CASCADE;
ALTER TABLE inventory
	ADD CONSTRAINT fk_inventory_branch
	FOREIGN KEY (branch_id) 
	REFERENCES (branch _id)
	ON DELETE CASCADE;

ALTER TABLE cart
	ADD CONSTRAINT fk_cart_product	
	FOREIGN KEY (product_id) 
	REFERENCES product (product_id) 
	ON DELETE CASCADE;
ALTER TABLE cart
	ADD CONSTRAINT fk_transaction_number 
	FOREIGN KEY (transaction_number) 
	REFERENCES sales_history (transaction_number)
	ON DELETE CASCADE;

ALTER TABLE sales_history
	ADD CONSTRAINT fk_sales_history_customer
	FOREIGN KEY (customer_id) 
	REFERENCES customer (customer_id)
	ON DELETE CASCADE;
ALTER TABLE sales_history
	ADD CONSTRAINT fk_sales_history_employee 
	FOREIGN KEY (cashier_id) 
	REFERENCES employee (employee_id) 
	ON DELETE CASCADE;
ALTER TABLE sales_history 
	ADD CONSTRAINT fk_sales_history_payment_method
	FOREIGN KEY (payment_method_id)
	REFERENCES payment_method _id) 
	ON DELETE CASCADE;

ALTER TABLE employee
	ADD CONSTRAINT fk_employee_role
	FOREIGN KEY (role_id)
	REFERENCES user_role (role_id);

ALTER TABLE employee
	ADD CONSTRAINT fk_employee_branch
	FOREIGN KEY (branch_id)
	REFERENCES branch _id);






