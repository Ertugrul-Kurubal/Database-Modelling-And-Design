--E-Commerce Question


USE [ECommerce]

--Q1
--Join all the tables and create a new table with all of the columns, called combined_table. 
--(market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)

SELECT A.Ord_id, A.Prod_id, A.Ship_id, A.Cust_id, A.Sales, A.Discount, A.Order_Quantity, 
A.Profit, A.Shipping_Cost, A.Product_Base_Margin, B.Cust_Name, B.Customer_Segment, B.Province, B.Region,
C.Order_Date, C.Order_Priority, D.Product_Category, D.Product_Sub_Category, E.Ship_Date, E.Ship_Mode
INTO combined_table
FROM [dbo].[market_fact] A
INNER JOIN [dbo].[cust_dimen] B
ON A.Cust_id = B.Cust_id
INNER JOIN [dbo].[orders_dimen] C
ON A.Ord_id = C.Ord_id
INNER JOIN [dbo].[prod_dimen] D
ON A.Prod_id = D.Prod_id
INNER JOIN [dbo].[shipping_dimen] E
ON A.Ship_id = E.Ship_id
;

SELECT * FROM combined_table

--Q2
--Find the top 3 customers who have the maximum count of orders.
--