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




















