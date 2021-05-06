------ SET OPERATIONS ------
-- UNION / UNION ALL
-- Fairport �ehrindeki m��teriler ile East Meadow �ehrindeki m��terilerin soyisimlerini listeleyin

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































