

--Assignment-2

--Q1 Changes in net worth

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
debit AS
		(
		SELECT [sender] as [user],
		SUM(CASE WHEN [sender] = [sender]  THEN amount ELSE 0 END) as debit
		FROM transactions
		GROUP BY [sender]
		),
credit AS
		(
		SELECT receiver as [user],		
		SUM(CASE WHEN receiver = receiver THEN amount ELSE 0 END) as credit
		FROM transactions
		GROUP BY receiver
		) 

SELECT *
FROM debit a
FULL OUTER JOIN credit b
ON a.[user] = b.[user]






--Q2
























































