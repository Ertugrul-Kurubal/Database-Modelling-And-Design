

--Assignment-2

--Q1

WITH transactions  AS
(
		SELECT * 
		FROM 
		(
			VALUES
			(5, 2, 10, CAST('02-12-20' AS date)),
			(1, 3, 15, CAST('02-13-20' AS date)), 
			(2, 1, 20, CAST('02-13-20' AS date)), 
			(2, 3, 25, CAST('02-14-20' AS date)), 
			(3, 1, 20, CAST('02-15-20' AS date)), 
			(3, 2, 15, CAST('02-15-20' AS date)), 
			(1, 4, 5,  CAST('02-16-20' AS date))
			)
		AS Table_1 ([sender], receiver, amount, [transaction-date]) 
),
Table_2 AS 
		(
		SELECT


SELECT * 
FROM transactions

--Q2
























































