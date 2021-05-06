------ SET OPERATIONS ------
-- UNION / UNION ALL
-- Fairport şehrindeki müşteriler ile East Meadow şehrindeki müşterilerin soyisimlerini listeleyin

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

-- IN logical operatörü kullanılarak da yapılabilir.

SELECT	last_name
FROM	sales.customers
WHERE	city IN ('Fairport', 'East Meadow')

-- IN logical operatörü kullanılarak da yapılabilir.

SELECT DISTINCT	last_name
FROM	sales.customers
WHERE	city IN ('Fairport', 'East Meadow')

-- Veritabanımızda bulunan bütün isim soyisimleri listeleyin.
-- Sonuçta sadece ad ve soyad olmak üzere iki sütun olacak.
-- UNION ve UNION ALL sonuçlarını karşılaştırın.

SELECT first_name, last_name FROM [sales].[staffs]
UNION
SELECT first_name, last_name FROM [sales].[customers]

SELECT first_name, last_name FROM [sales].[staffs]
UNION ALL
SELECT first_name, last_name FROM [sales].[customers]



























