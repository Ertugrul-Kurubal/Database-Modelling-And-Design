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































