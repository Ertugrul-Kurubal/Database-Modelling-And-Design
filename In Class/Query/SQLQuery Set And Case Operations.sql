------ SET OPERATIONS ------
-- UNION / UNION ALL
-- Fairport þehrindeki müþteriler ile East Meadow þehrindeki müþterilerin soyisimlerini listeleyin

SELECT last_name 
FROM [sales].[customers]
WHERE city = 'Fairport'
UNION
SELECT last_name 
FROM [sales].[customers]
WHERE city = 'East Meadow'

SELECT last_name 
FROM [sales].[customers]
WHERE city = 'Fairport'
UNION ALL
SELECT last_name 
FROM [sales].[customers]
WHERE city = 'East Meadow'
ORDER BY last_name 

-- IN logical operatörü kullanýlarak da yapýlabilir.

SELECT	last_name
FROM	sales.customers
WHERE	city IN ('Fairport', 'East Meadow')

-- IN logical operatörü kullanýlarak da yapýlabilir.

SELECT DISTINCT	last_name
FROM	sales.customers
WHERE	city IN ('Fairport', 'East Meadow')

-- Veritabanýmýzda bulunan bütün isim soyisimleri listeleyin.
-- Sonuçta sadece ad ve soyad olmak üzere iki sütun olacak.
-- UNION ve UNION ALL sonuçlarýný karþýlaþtýrýn.

SELECT first_name, last_name FROM [sales].[staffs]
UNION
SELECT first_name, last_name FROM [sales].[customers]

SELECT first_name, last_name FROM [sales].[staffs]
UNION ALL
SELECT first_name, last_name FROM [sales].[customers]

--Hangi kiþi iki defa listede gözüküyor 

WITH t1 AS
(
SELECT first_name, last_name FROM [sales].[staffs]
UNION ALL
SELECT first_name, last_name FROM [sales].[customers]
)

SELECT first_name, last_name, count(*) freq
FROM t1
GROUP BY first_name, last_name
HAVING count(*) = 2

SELECT	store_name     --data type varchar(255) büyük data olaný yukarý yazmak daha mantýklý
FROM	sales.stores   --ÇÜnkü birleþme iþlemi ilk tablonun adýný alarak oluþuyor eðer isimler farklý ise
UNION
SELECT	state          --data type varchar(25)
FROM	sales.customers
;

SELECT CAST ('ALÝ' AS VARCHAR(3))
UNION ALL
SELECT CAST ('CELALETTIN' AS VARCHAR(10))

SELECT	*
FROM	production.brands
UNION
SELECT	*
FROM	production.categories
;

-- INTERSECT / EXCEPT
-- Hangi marka bisikletlerin hem 2016 hem de 2017 modelleri bulunmaktadýr?
-- brand_id ve brand_name deðerlerini listeleyin

SELECT brand_id FROM [production].[products]
WHERE model_year = 2016
INTERSECT
SELECT brand_id FROM [production].[products]
WHERE model_year = 2017

SELECT brand_id, brand_name 
FROM [production].[brands]
WHERE brand_id IN (SELECT brand_id FROM [production].[products]
					WHERE model_year = 2016
					INTERSECT
					SELECT brand_id FROM [production].[products]
					WHERE model_year = 2017
					)

SELECT	brand_id --, COUNT(DISTINCT model_year) f_model_year
FROM	production.products
WHERE	model_year IN (2016, 2017)
GROUP BY brand_id
HAVING	COUNT(DISTINCT model_year) = 2;

-- Hem 2016, hem 2017 hem de 2018 yýllarýnda sipariþ veren müþterileri listeleyiniz.

SELECT first_name, last_name FROM [sales].[customers]
WHERE customer_id IN (SELECT customer_id FROM [sales].[orders]
					WHERE YEAR(order_date) = 2016
					INTERSECT
					SELECT customer_id FROM [sales].[orders]
					WHERE YEAR(order_date) = 2017
					INTERSECT
					SELECT customer_id FROM [sales].[orders]
					WHERE YEAR(order_date) = 2018
					)

--2-way

SELECT first_name, last_name FROM [sales].[customers]
WHERE customer_id IN (SELECT customer_id FROM [sales].[orders]
					WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31'
					INTERSECT
					SELECT customer_id FROM [sales].[orders]
					WHERE YEAR(order_date) = 2017
					INTERSECT
					SELECT customer_id FROM [sales].[orders]
					WHERE DATEPART(year, order_date) = 2018
					)

-- 2016 model bisiklet markalarýndan hangilerinin 2017 model bisikleti yoktur?
-- brand_id ve brand_name deðerlerini listeleyin

SELECT brand_id 
FROM [production].[products]
WHERE model_year = 2016
EXCEPT
SELECT brand_id 
FROM [production].[products]
WHERE model_year = 2017

SELECT * 
FROM [production].[brands]
WHERE brand_id IN (SELECT brand_id 
					FROM [production].[products]
					WHERE model_year = 2016
					EXCEPT
					SELECT brand_id 
					FROM [production].[products]
					WHERE model_year = 2017
					)

-- Sadece 2017 yýlýnda satýlan, diðer yýllarda satýlmayan bisikletleri listeleyin.
-- Bu kurala uyan bisiklet varsa product_id ve product_name bilgilerini listeleyin

SELECT B.product_id 
FROM [sales].[orders] A, [sales].[order_items] B
WHERE YEAR(order_date) = 2017 AND A.order_id = B.order_id
EXCEPT
SELECT B.product_id 
FROM [sales].[orders] A, [sales].[order_items] B
WHERE A.order_id = B.order_id AND YEAR(order_date) <> 2017

SELECT product_id, product_name 
FROM [production].[products]
WHERE product_id IN (SELECT B.product_id 
			FROM [sales].[orders] A, [sales].[order_items] B
			WHERE YEAR(order_date) = 2017 AND A.order_id = B.order_id
			EXCEPT
			SELECT B.product_id 
			FROM [sales].[orders] A, [sales].[order_items] B
			WHERE A.order_id = B.order_id AND YEAR(order_date) <> 2017
			)

SELECT product_id, product_name 
FROM [production].[products]
WHERE product_id IN (SELECT B.product_id 
			FROM [sales].[orders] A, [sales].[order_items] B
			WHERE YEAR(order_date) = 2017 AND A.order_id = B.order_id
			EXCEPT
			SELECT B.product_id 
			FROM [sales].[orders] A, [sales].[order_items] B
			WHERE A.order_id = B.order_id AND (YEAR(order_date) < 2017 OR 
			YEAR(order_date) > 2017))

------ CASE EXPRESSION ------
-- Simple Case Expression -----
-- Order status id lerinin açýklamalarýný yazdýrýnýz.
-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed

SELECT *, 
	CASE order_status 
		WHEN 1 THEN 'Pending'
		WHEN 2 THEN 'Processing'
		WHEN 3 THEN 'Rejected'
		WHEN 4 THEN 'Completed'
		ELSE 'Undefined'
	END AS order_def
FROM [sales].[orders]
;

-- Personellerin çalýþtýklarý maðaza isimlerini simple case expression ile yazdýrýnýz.

SELECT *, 
		CASE store_id
			WHEN 1 THEN 'Santa Cruz Bikes'
			WHEN 2 THEN 'Baldwin Bikes'
			WHEN 3 THEN 'Rowlett Bikes'
			ELSE 'Undefined'
		END AS store_name
FROM [sales].[staffs]
;






























