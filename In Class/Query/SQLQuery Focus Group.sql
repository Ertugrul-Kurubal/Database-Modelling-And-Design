--FOCUS GROUP

-- WITH 

--En y�ksek fiyatl� bisitletin markas� nedir?

WITH T1 AS (
SELECT TOP 1 *

)
SELECT * 
FROM T1 A, [production].[brands] B
WHERE A.brand_id = B.brand_id

-- En pahal� bisitletten sat�n alan m��terileri bulunuz.

WITH T1 AS (
SELECT TOP 1 *
FROM [production].[products]
ORDER BY list_price DESC
), T2 AS (
SELECT B.order_id
FROM T1 A, [sales].[order_items] B
WHERE A.product_id = B.product_id
), T3 AS (
SELECT B.customer_id
FROM T2 A, sales.orders B
WHERE A.order_id = B.order_id
)
SELECT B.first_name, B.last_name
FROM T3 A, [sales].[customers] B
WHERE A.customer_id = B.customer_id

-- How to query the factorial of 6 recursively?

WITH factorial_func (step, factorial) AS
		(SELECT 1, 1
		UNION ALL
		SELECT step + 1, (step + 1) * factorial
		FROM factorial_func
		WHERE step < 6 
		)
		
SELECT step, factorial
FROM factorial_func

--2 way
/*
WITH factorial6 (step, result) AS (
SELECT step = 0, result = 1
UNION ALL
SELECT step + 1, result = (step + 1) * result
FROM factorial6
WHERE step < 6
)
SELECT *
FROM factorial6;
*/

-- VIEW
