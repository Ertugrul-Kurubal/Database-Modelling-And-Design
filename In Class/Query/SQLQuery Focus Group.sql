--FOCUS GROUP

-- WITH 

-- 2019da �retilen bisiklet kategorileri nelerdir?

WITH T1 AS (
SELECT *
FROM production.products
WHERE model_year = 2019 
)
SELECT DISTINCT B.category_name
FROM T1 A, production.categories B
WHERE A.category_id = B.category_id
;

-- En y�ksek fiyatl� bisitletin markas� nedir?

WITH T1 AS (
SELECT TOP 1 *
FROM production.products
ORDER BY list_price DESC
)
SELECT B.brand_name
FROM T1 A, production.brands B
WHERE A.brand_id = B.brand_id;

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
;

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

-- Sipari� ile kargo s�resi aras�nda 3 g�n olan sipari�lerden view olu�turun.

CREATE VIEW three_days AS
	SELECT * 
	FROM sales.orders
	WHERE DATEDIFF(DAY, order_date, shipped_date) = 3;

DROP VIEW three_days;

SELECT *
FROM three_days
WHERE staff_id=6;

-- WINDOW FUNCTIONS EXAMPLES

-- Orders tablosundaki sipari� say�s�n� ve m��terilere ait sipari� say�lar�n� bir Select sorgusunda getiriniz.

SELECT	DISTINCT customer_id, 
		COUNT (*) OVER (PARTITION BY customer_id) customer_orders,
		COUNT (order_id) OVER () total_orders
FROM	sales.orders;

-- Sipari� tablosundaki order_date'leri ascending olacak �ekilde s�ralay�n

SELECT order_date
FROM sales.orders
ORDER BY order_date
;

-- Her bir sipari� tarihinin bir �nceki ve bir sonraki sipari� tarihini yukar�daki tabloya ekleyiniz.
-- desired output : [order_date, pre_order_date, next_order_date]

SELECT order_date,
LAG(order_date) OVER(ORDER BY order_date) AS pre_order_date,
LEAD(order_date) OVER(ORDER BY order_date) AS next_order_date
FROM sales.orders;

-- Her customer_id'nin yan�na sipari� tarihine g�re kendisinden bir sonraki sipari�i veren customer_id'yi yazd�r�n�z
-- desired output: customer_id, next_customer

SELECT customer_id, order_Date,
 LEAD(customer_id)	OVER(ORDER BY order_date) AS next_customer_id
FROM sales.orders
ORDER BY order_date;

-- RANK, DENSE_RANK VE ROW_NUMBER FONKS�YONLARININ KAR�ILA�TIRILMASI

-- Sipari�leri order_date'e g�re artan �ekilde numaraland�r�n (NULL order_date'i ��LEME DAH�L ETMEY�N�Z)

-- ROW NUMBER()

SELECT order_id, order_date,
	row_number()	OVER(ORDER BY order_date DESC) as number
FROM sales.orders
WHERE order_date IS NOT NULL;

-- RANK()

SELECT order_id, order_date,
	RANK()	OVER(ORDER BY order_date) as number
FROM sales.orders
WHERE order_date IS NOT NULL;

--DENSE_RANK()

SELECT	order_id, order_date,
		DENSE_RANK() OVER (ORDER BY order_date) number
FROM	sales.orders
WHERE order_date IS NOT NULL;

-- Yukar�daki numaraland�rmay� order_status k�r�l�m�na g�re yeniden yap�n�z.

SELECT	order_status, order_id, order_date,
		DENSE_RANK() OVER (PARTITION BY order_status ORDER BY order_date) number
FROM	sales.orders
WHERE order_date IS NOT NULL;

with cte as(
SELECT order_id, order_date,
DENSE_RANK() over(ORDER BY order_date) [Dense]
from sales.orders
where order_date is not Null
)
select order_id, order_date, Dense,
COUNT(*) over (partition by Dense Order By Dense)
from cte