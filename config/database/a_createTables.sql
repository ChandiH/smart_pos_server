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
    user_access_id INTEGER  PRIMARY KEY,
    role_id INTEGER NOT NULL,
    access_type_id INTEGER NOT NULL
);

-- Category
CREATE TABLE category (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);



-- Products
CREATE TABLE product (
    product_id INTEGER  PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    product_desc VARCHAR(200),
    category_id INTEGER NOT NULL,
    product_image VARCHAR [], 
    buying_price NUMERIC(1000, 2) NOT NULL,
    retail_price NUMERIC(1000, 2),
    discount NUMERIC(1000, 2),
    supplier_id INTEGER NOT NULL,
    product_barcode VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP WITHOUT TIME ZONE
);

-- Inventory
CREATE TABLE inventory (
    product_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    quantity INTEGER check (quantity >= 0),
    reorder_level INTEGER ,
    updated_on TIMESTAMP WITHOUT TIME ZONE,
    PRIMARY KEY(product_id, branch_id)
);

-- Cart
CREATE TABLE cart (
    cart_id INTEGER  PRIMARY KEY,
    order_id INTEGER ,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL check (quantity > 0),
    sub_total_amount NUMERIC(1000, 2) check (sub_total_amount > 0),
    created_at date DEFAULT CURRENT_DATE
);

-- Orders
CREATE TABLE sales_history (
    order_id INTEGER  PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    cashier_id INTEGER NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(1000,2) check (total_amount > 0),
    payment_method_id INTEGER ,
    reference_ID VARCHAR(255) UNIQUE 
    -- product count
    -- profit NUMERIC(1000,2) DEFAULT 0.00,
    -- do we need to add discount type in a field?
    -- direct: add branch id (is it okay with db standards?) 
);

--customer
CREATE TABLE customer (
    customer_id INTEGER  PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) UNIQUE,
    customer_phone VARCHAR(13) NOT NULL UNIQUE,
    customer_address VARCHAR(200),
    visit_count INTEGER default 0,
    rewards_points NUMERIC(1000, 2) default 0.00,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


--user credentials
CREATE TABLE user_credentials (
    user_id INTEGER PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL UNIQUE,
    updated_on TIMESTAMP WITHOUT TIME ZONE
);

-- Employee
CREATE TABLE employee (
    employee_id INTEGER  PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    role_id INTEGER NOT NULL,
    hired_date DATE DEFAULT CURRENT_DATE,
    employee_email VARCHAR(255) UNIQUE,
    employee_phone VARCHAR(13) NOT NULL UNIQUE ,
    branch_id INTEGER NOT NULL,
    updated_on DATE 
);

-- Suppliers
CREATE TABLE supplier (
    supplier_id INTEGER  PRIMARY KEY,
    supplier_name VARCHAR(200) NOT NULL ,
    supplier_email VARCHAR(255) UNIQUE,
    supplier_phone VARCHAR(13) NOT NULL UNIQUE,
    supplier_address VARCHAR(200) NOT NULL
);

CREATE TABLE payment_method (
    payment_method_id INTEGER  PRIMARY KEY,
    payment_method_name VARCHAR(255) NOT NULL UNIQUE
);

-- Discounts and promotions
CREATE TABLE discount (
    discount_id INTEGER  PRIMARY KEY,
    discount_name VARCHAR(255) NOT NULL UNIQUE,
    discount_desc VARCHAR(200),
    discount_percentage NUMERIC(5, 2) NOT NULL
);

CREATE TABLE branch (
    branch_id INTEGER  PRIMARY KEY,
    branch_city VARCHAR(255) NOT NULL UNIQUE ,
    branch_address VARCHAR(200) NOT NULL,
    branch_phone VARCHAR(13) NOT NULL UNIQUE,
    branch_email VARCHAR(255) NOT NULL UNIQUE
);

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

ALTER TABLE inventory 
	ADD CONSTRAINT fk_inventory_product
	FOREIGN KEY (product_id)
	REFERENCES product (product_id)
	ON DELETE CASCADE;
ALTER TABLE inventory
	ADD CONSTRAINT fk_inventory_branch
	FOREIGN KEY (branch_id) 
	REFERENCES branch (branch_id)
	ON DELETE CASCADE;

ALTER TABLE cart
	ADD CONSTRAINT fk_cart_product	
	FOREIGN KEY (product_id) 
	REFERENCES product (product_id) 
	ON DELETE CASCADE;
ALTER TABLE cart
	ADD CONSTRAINT fk_cart_sales_history
	FOREIGN KEY (order_id) 
	REFERENCES sales_history (order_id)
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
	REFERENCES payment_method (payment_method_id)
	ON DELETE CASCADE;

ALTER TABLE user_credentials
    ADD CONSTRAINT fk_user_credentials_employee
    FOREIGN KEY (user_id)
    REFERENCES employee (employee_id)
    ON DELETE CASCADE;

ALTER TABLE employee
	ADD CONSTRAINT fk_employee_role
	FOREIGN KEY (role_id)
	REFERENCES user_role (role_id);

ALTER TABLE employee
	ADD CONSTRAINT fk_employee_branch
	FOREIGN KEY (branch_id)
	REFERENCES branch(branch_id);