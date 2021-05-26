--E-Commerce Question


USE [ECommerce]

--Analyze the data by finding the answers to the questions below:

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
;DA

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

/* IN CLASS
ALTER TABLE [dbo].[combined_table]
ADD DaysTakenForDelivery

UPDATE combined_table
SET DaysTakenForDelivery = DATEDIFF(DAY, Order_Date, Ship_Date) 
*/


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

/* IN CLASS
SELECT Cust_id, Ord_id, DaysTakenForDelivery
FROM [dbo].[combined_table]
WHERE DaysTakenForDelivery = (SELECT MAX(DaysTakenForDelivery)
							  FROM [dbo].[combined_table]
							  )
*/

SELECT * FROM 
[dbo].[combined_table]
WHERE Ord_id = 'Ord_4335'

--Q5
--Retrieve total sales made by each product from the data (use Window function)

SELECT *, SUM(CAST(Sales AS integer)) OVER(PARTITION BY Prod_id) prd_tot_sales
FROM [dbo].[combined_table]

/* IN CLASS
SELECT DISTINCT Prod_id, SUM(Sales) OVER (PARTITION BY Prod_id) tot_sales
FROM [dbo].[combined_table]
ORDER BY tot_sales
*/

--Q6
--Retrieve total profit made from each product from the data (use windows function)

SELECT *, SUM(CAST(Profit AS bigint)) OVER(PARTITION BY Prod_id) prd_tot_profit
FROM [dbo].[combined_table]

/* IN CLASS
SELECT DISTINCT Prod_id, SUM(CAST(Profit AS bigint)) OVER(PARTITION BY Prod_id) prd_tot_profit
FROM [dbo].[combined_table]
ORDER BY prd_tot_profit DESC
*/

--Q7 ???
--Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011

SELECT COUNT(DISTINCT Cust_id) cust_num
FROM [dbo].[combined_table]
WHERE MONTH(Order_Date) = 01

/* IN CLASS
SELECT DISTINCT MONTH(Order_Date) AS [Month],
		COUNT(DISTINCT Cust_id) AS cust_num
FROM [dbo].[combined_table] A
WHERE
EXISTS
     (
     SELECT Cust_id
     FROM [dbo].[combined_table] B
     WHERE  A.Cust_id = B.Cust_id 
			AND YEAR (Order_Date) = 2011
			AND MONTH(Order_Date) = 01
     )
AND YEAR (Order_Date) = 2011
GROUP BY MONTH(Order_Date)
*/

--Q8
--Write a query to return for each user the time elapsed between the first purchasing and the third purchasing, in ascending order by Customer ID.

SELECT * ,DATEDIFF(DAY, (FIRST_VALUE(Order_Date) OVER(PARTITION BY Cust_id ORDER BY Order_Date)), (LEAD(Order_Date,2) OVER(PARTITION BY Cust_id ORDER BY Order_Date))) AS first_third_diff
FROM [dbo].[combined_table]
ORDER BY Cust_id ASC

/* IN CLASS
SELECT Cust_id, MIN (Order_date) first_purchase
FROM combined_table
GROUP BY Cust_id


SELECT Cust_id,
		Order_Date as third_purchase,
		dens_rank,
		first_purchase, 
		DATEDIFF(DAY, first_purchase, Order_Date) first_third_diff
FROM 
        (
        SELECT Cust_id,
        		Order_Date,
        		Ord_id,
        		MIN (Order_date) OVER (PARTITION BY Cust_id) first_purchase
        		DENSE_RANK() OVER(PARTITION BY Cust_id ORDER BY Order_Date) dens_rank
        FROM combined_table
        ) A
WHERE dens_rank = 3
*/

/*
SELECT *
FROM [dbo].[combined_table]
WHERE Cust_id = 'Cust_100'
ORDER BY Cust_id, Order_Date

SELECT DATEDIFF(DAY, '2009-06-21', '2010-05-07')

SELECT FIRST_VALUE(Order_Date) OVER(PARTITION BY Cust_id ORDER BY Order_Date) first_ord
FROM [dbo].[combined_table]
ORDER BY Cust_id, Order_Date


SELECT LEAD(Order_Date,2) OVER(PARTITION BY Cust_id ORDER BY Order_Date) third_ord
FROM [dbo].[combined_table]
ORDER BY Cust_id, Order_Date
*/

--Q9 ???
--Write a query that returns customers who purchased both product 11 and product 14 as well as the ratio of 
--these products to the total number of products purchased by the customer.

SELECT *, COUNT(Prod_id) OVER (PARTITION BY Cust_id) ord_num
FROM [dbo].[combined_table] 
WHERE Prod_id = 'Prod_11' OR Prod_id = 'Prod_14'
ORDER BY Cust_id

SELECT *
FROM [dbo].[combined_table] 

/* IN CLASS
WITH T1 AS
(
SELECT Cust_id,
		SUM(CASE WHEN Prod_id = 'Prod_11' THEN 1 ELSE 0 END) AS P11,
		SUM(CASE WHEN Prod_id = 'Prod_14' THEN 1 ELSE 0 END) AS P14,
		COUNT(Prod_id) tot_prod
FROM [dbo].[combined_table]
GROUP BY Cust_id
HAVING 
		SUM(CASE WHEN Prod_id = 'Prod_11' THEN 1 ELSE 0 END) >=1 AND
		SUM(CASE WHEN Prod_id = 'Prod_14' THEN 1 ELSE 0 END) >=1
)
SELECT Cust_id, P11, P14, tot_prod
		CAST(1.0*P11/tot_prod AS NUMERIC (3,2)) AS ratio_P11,
		CAST(1.0*P14/tot_prod AS NUMERIC (3,2)) AS ratio_P14
FROM T1
*/

/*
ALTER TABLE [dbo].[combined_table]
ALTER COLUMN Order_Quantity int
*/

SELECT Cust_id, COUNT(Prod_id) tot_prod_num 
FROM [dbo].[combined_table] 
WHERE Cust_id IN (SELECT Cust_id
					FROM [dbo].[combined_table] 
					WHERE Prod_id = 'Prod_11'
					INTERSECT
					SELECT Cust_id
					FROM [dbo].[combined_table] 
					WHERE Prod_id = 'Prod_14'
					)
GROUP BY Cust_id 
;

SELECT Cust_id, COUNT(Prod_id) prod_num
FROM [dbo].[combined_table] 
WHERE Cust_id IN (SELECT Cust_id
					FROM [dbo].[combined_table] 
					WHERE Prod_id = 'Prod_11'
					INTERSECT
					SELECT Cust_id
					FROM [dbo].[combined_table] 
					WHERE Prod_id = 'Prod_14'
					)
		AND Prod_id IN ('Prod_11','Prod_14')
GROUP BY Cust_id 
;

--Find month-by-month customer retention ratei since the start of the business (using views).

--Q1
--Create a view where each user’s visits are logged by month, allowing for the possibility that 
--these will have occurred over multiple years since whenever business started operations.

/* IN CLASS
CREATE VIEW Customer_Logs
AS
SELECT Cust_id,
		YEAR(Order_Date) [Year],
		MONTH(Order_Date) [Month],
		COUNT(*) total_visit,
		DENSE_RANK() OVER (ORDER BY YEAR(Order_Date), MONTH(Order_Date)) dense_month
FROM [dbo].[combined_table]
GROUP BY Cust_id, MONTH(Order_Date), YEAR(Order_Date)
*/

--Q2
--Identify the time lapse between each visit. So, for each person and for each month, we see when the next visit is.

/* IN CLASS
CREATE VIEW Next_Visit_VW
AS
SELECT *,
		LEAD(dense_month) OVER(PARTITION BY Cust_id ORDER BY dense_month) next_visit_month
FROM Customer_Logs
*/

--Q3
--Calculate the time gaps between visits.

/* IN CLASS !!! Kontrol et
CREATE VIEW Time_Gaps_VW
AS
SELECT *, Next_Visit_VW - dense_month AS time_gaps
FROM Next_Visit_VW
*/

--Q4
--Categorise the customer with time gap 1 as retained, >1 as irregular and NULL as churned.

/* IN CLASS
SELECT Cust_id, Customer_Name, avg_time_gap,
		CASE 
			WHEN avg_time_gap = 1 THEN 'retained'
			WHEN avg_time_gap > 1 THEN 'irregular'
			WHEN avg_time_gap IS NULL THEN 'churned'
		ELSE 'Unkown_Data' END Cust_Class
FROM (
		SELECT Cust_id, AVG(time_gaps) avg_time_gap
		FROM Time_Gaps_VW
		GROUP BY Cust_id
		) A
*/

--Q5
--Calculate the retention month wise.

/* IN CLASS !!! Kontrol et
SELECT DISTINCT next_visit_month,
		COUNT(Cust_id) OVER(PARTITION BY dense_month) retention_sum_monthly
FROM Time_Gaps_VW
WHERE time_gaps = 1
ORDER BY retention_sum_monthly DESC
*/











