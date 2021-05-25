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

SELECT * FROM [dbo].[combined_table]

SELECT TOP(3) Cust_Name, COUNT(Ord_id) AS cnt_ord
FROM [dbo].[combined_table]
GROUP BY Cust_Name
ORDER BY cnt_ord DESC

--Q3
--Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.

ALTER TABLE [dbo].[combined_table]
ADD DaysTakenForDelivery AS DATEDIFF(DAY, Order_Date, Ship_Date)

/*
ALTER TABLE [dbo].[combined_table]
DROP COLUMN DaysTakenForDelivery
*/

SELECT * FROM [dbo].[combined_table]

--Q4
--Find the customer whose order took the maximum time to get delivered.

SELECT TOP(1) Cust_Name, Ord_id, DaysTakenForDelivery
FROM [dbo].[combined_table]
ORDER BY DaysTakenForDelivery DESC

SELECT * FROM 
[dbo].[combined_table]
WHERE Ord_id = 'Ord_4335'

--Q5
--Retrieve total sales made by each product from the data (use Window function)

SELECT *, SUM(CAST(Order_Quantity AS integer)) OVER(PARTITION BY Prod_id) prd_tot_sales
FROM [dbo].[combined_table]

