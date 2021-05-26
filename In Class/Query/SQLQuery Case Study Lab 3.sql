
--DAwSQL Lab-3

--Case study

-- 1. Count the number of customers, that placed at least 1 order, whose last_name is “Larson”

SELECT COUNT(DISTINCT A.customer_id) Num_Of_Cust
FROM [sales].[customers] A
INNER JOIN [sales].[orders] B
ON A.customer_id = B.customer_id
WHERE A.last_name = 'Larson'
;
/*
SELECT COUNT(A.customer_id)
FROM sales.customers A, sales.orders B
WHERE A.customer_id = B.customer_id AND A.last_name = 'Larson'
;
*/

--Count the number of different cities where at least 1 order has been placed one day 
--earlier from '2016-08-18'  (do not hardcode the date)

SELECT COUNT(DISTINCT A.city) Num_Of_City
FROM [sales].[customers] A
INNER JOIN [sales].[orders] B
ON A.customer_id = B.customer_id
WHERE B.order_date = DATEADD(DAY, -1, '2016-08-18')
;

-- Find the weekly order count for the city of Baldwin for the last 8 weeks earlier from '2016-08-18', and also the cumulative total.
-- Desired output: [week, order_count, cuml_order_count]

SELECT DISTINCT DATEPART(WEEK, A.order_date), 
		COUNT(A.order_id) OVER (PARTITION BY DATEPART(WEEK, order_date)) order_count,
		COUNT(A.order_id) OVER (ORDER BY DATEPART(WEEK, order_date)) order_count     --For Cumulative 
FROM [sales].[orders] A
INNER JOIN [sales].[stores] B
ON A.store_id = B.store_id
WHERE B.city = 'Baldwin' AND A.order_date BETWEEN DATEADD(WEEK, -8, '2016-08-18') AND '2016-08-18'








