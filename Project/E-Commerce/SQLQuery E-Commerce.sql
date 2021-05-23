--E-Commerce Project

CREATE DATABASE ECommerce;

USE ECommerce;

CREATE TABLE shipping_dimen 
(
Ship_id nvarchar(20),
Ship_Mode nvarchar(20) NOT NULL,
Ship_Date date NOT NULL,
PRIMARY KEY (Ship_id)
);

CREATE TABLE prod_dimen 
(
Prod_id nvarchar(20),
Product_Category nvarchar(20) NOT NULL,
Product_Sub_Category nvarchar(50) NOT NULL,
PRIMARY KEY (Prod_id)
);

CREATE TABLE prod_dimen 
(
Prod_id nvarchar(20),
Product_Category nvarchar(20) NOT NULL,
Product_Sub_Category nvarchar(50) NOT NULL,
PRIMARY KEY (Prod_id)
);