--E-Commerce Project

CREATE DATABASE ECommerce;

USE ECommerce;

CREATE TABLE shipping_dimen 
(
Ship_Mode nvarchar(20) NOT NULL,
Ship_Date date NOT NULL,
Ship_id nvarchar(20)
PRIMARY KEY (Ship_id)
);

CREATE TABLE prod_dimen 
(
Product_Category nvarchar(20) NOT NULL,
Product_Sub_Category nvarchar(50) NOT NULL,
Prod_id nvarchar(20)
PRIMARY KEY (Prod_id)
);

CREATE TABLE order_dimen 
(
Order_Date date NOT NULL,
Order_Priority nvarchar(20) NOT NULL,
Order_id nvarchar(20)
PRIMARY KEY (Order_id)
);

CREATE TABLE cust_dimen 
(
Cust_Name nvarchar(20) NOT NULL,
Province nvarchar(20),
Region nvarchar(20),
Customer_Segment nvarchar(20),
Cust_id nvarchar(20)
PRIMARY KEY (Cust_id)
);

CREATE TABLE market_fact 
(
Order_id nvarchar(20),
Prod_id nvarchar(20),
Ship_id nvarchar(20),
Cust_id nvarchar(20),
Sales float,
Discount float,
Order_Quantity int,
Profit float,
Shipping_Cost float,
Product_Base_Margin float
FOREIGN KEY (Order_id) REFERENCES order_dimen (Order_id),
FOREIGN KEY (Prod_id) REFERENCES prod_dimen (Prod_id),
FOREIGN KEY (Ship_id) REFERENCES shipping_dimen (Ship_id),
FOREIGN KEY (Cust_id) REFERENCES cust_dimen (Cust_id)
);

ALTER TABLE order_dimen
ALTER COLUMN Order_Date date

ALTER TABLE order_dimen
ALTER COLUMN Order_Priority nvarchar(20)

ALTER TABLE prod_dimen
ALTER COLUMN Product_Category nvarchar(20)

ALTER TABLE prod_dimen
ALTER COLUMN Product_Sub_Category nvarchar(50)

ALTER TABLE shipping_dimen
ALTER COLUMN Ship_Mode nvarchar(20)

ALTER TABLE shipping_dimen
ALTER COLUMN Ship_Date date

/*
ALTER TABLE table_name
ADD column_name datatype;

ALTER TABLE Customers
ADD Email varchar(255);

ALTER TABLE table_name
MODIFY COLUMN column_name datatype; --MySQL

ALTER TABLE Customers
DROP COLUMN Email;
*/

