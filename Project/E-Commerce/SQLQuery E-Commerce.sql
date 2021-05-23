--E-Commerce Project

CREATE DATABASE ECommerce;

USE ECommerce;

CREATE TABLE shipping_dimen 
(
Ship_Mode nvarchar(50),
Ship_Date date,
Ship_id nvarchar(50)
PRIMARY KEY (Ship_id)
);

CREATE TABLE prod_dimen 
(
Product_Category nvarchar(50),
Product_Sub_Category nvarchar(50),
Prod_id nvarchar(50)
PRIMARY KEY (Prod_id)
);

CREATE TABLE order_dimen 
(
Order_Date date,
Order_Priority nvarchar(50),
Order_id nvarchar(50)
PRIMARY KEY (Order_id)
);

CREATE TABLE cust_dimen 
(
Cust_Name nvarchar(50),
Province nvarchar(50),
Region nvarchar(50),
Customer_Segment nvarchar(50),
Cust_id nvarchar(50)
PRIMARY KEY (Cust_id)
);

CREATE TABLE market_fact 
(
Order_id nvarchar(50),
Prod_id nvarchar(50),
Ship_id nvarchar(50),
Cust_id nvarchar(50),
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


/*
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

ALTER TABLE cust_dimen
ALTER COLUMN Cust_Name nvarchar(50)
*/

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

