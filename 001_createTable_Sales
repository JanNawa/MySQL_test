USE Sales;

CREATE TABLE IF NOT EXISTS sales (
	purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
	customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    number_of_complaints INT
);

SELECT * FROM sales;
SELECT * FROM sales.sales;

DROP TABLE sales;

CREATE TABLE IF NOT EXISTS sales (
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (purchase_number)
);

DROP TABLE customers;

CREATE TABLE IF NOT EXISTS customers (
	customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS items (
	item_id VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10,2),
    company_id VARCHAR(255),
    PRIMARY KEY (item_id)
);

CREATE TABLE IF NOT EXISTS companies (
	company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquaters_phone_number INTEGER(12),
    PRIMARY KEY (company_id)
);

ALTER TABLE sales 
	ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
    
ALTER TABLE sales
	DROP FOREIGN KEY sales_ibfk_1;
    
ALTER TABLE customers
	ADD UNIQUE KEY (email_address);
    
ALTER TABLE customers
	DROP INDEX email_address;
    
DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
DROP TABLE companies;

CREATE TABLE IF NOT EXISTS customers (
	customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);

ALTER TABLE customers
	ADD COLUMN gender ENUM('M','F') AFTER last_name;
    
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
	VALUES ('John','Mackinley','M','john.mckinley@365careers.com',0);

ALTER TABLE customers
	CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;
    
INSERT INTO customers (first_name, last_name, gender)
	VALUES ('Peter', 'Figaro', 'M');
    
SELECT * FROM customers;

CREATE TABLE companies (
	company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquaters_phone_number INT(12),
    PRIMARY KEY(company_id),
    UNIQUE KEY(headquaters_phone_number)
);

DROP TABLE companies;

CREATE TABLE companies (
	company_id INT AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    headquaters_phone_number VARCHAR(255),
    PRIMARY KEY(company_id),
    UNIQUE KEY(headquaters_phone_number)
);

ALTER TABLE companies
	MODIFY company_name VARCHAR(255) NULL;
    
ALTER TABLE companies
	CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;
    
INSERT INTO companies (headquaters_phone_number, company_name)
	VALUES ('+1 (202) 555-0196', 'Company A');
    
SELECT * FROM companies;

ALTER TABLE companies
	MODIFY headquaters_phone_number VARCHAR(255) NULL;
    
ALTER TABLE companies
	CHANGE COLUMN headquaters_phone_number headquaters_phone_number VARCHAR(255) NOT NULL;
