-- Create Tables

-- User roles
CREATE TABLE user_role (
    role_ID SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    role_desc VARCHAR(200) NOT NULL
);

-- Access type
CREATE TABLE access_type (
    access_type_ID SERIAL PRIMARY KEY,
    access_name VARCHAR(100) NOT NULL
);



-- User access
CREATE TABLE user_access (
    user_access_ID BIGSERIAL PRIMARY KEY,
    role_ID INTEGER NOT NULL,
    access_type_ID INTEGER NOT NULL
);

-- Category
CREATE TABLE category (
    category_ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Products
CREATE TABLE product (
    product_ID SERIAL PRIMARY KEY,
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
    ID SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    quantity INTEGER,
    updated_on DATE,
    reorder_level INTEGER
);

-- Cart
CREATE TABLE cart (
    cart_ID SERIAL PRIMARY KEY,
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
    uom_ID SERIAL PRIMARY KEY,
    uom_name VARCHAR(60) NOT NULL,
    abbreviations VARCHAR(30) NOT NULL
);

-- Customer
CREATE TABLE customer (
    customer_ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
   phone VARCHAR(13) NOT NULL,
    address VARCHAR(200),
    visit_count INTEGER,
    points INTEGER
);

-- Employee
CREATE TABLE employee (
    employee_ID SERIAL PRIMARY KEY,
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
    supplier_ID SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(255),
   phone VARCHAR(13) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- Payment method
CREATE TABLE payment_method (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Discounts and promotions
CREATE TABLE discounts_and_promotions (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(200),
    discount_percentage NUMERIC(5, 2) NOT NULL
);

-- Gift cards
CREATE TABLE gift_cards (
    ID SERIAL PRIMARY KEY,
    card_number VARCHAR(255) NOT NULL,
    card_value NUMERIC(1000, 2),
    expire_date DATE
);

-- Branch
CREATE TABLE branch (
    ID SERIAL PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    address VARCHAR(200) NOT NULL
);

