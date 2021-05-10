

--Assignment-2

--Q1

WITH transactions  AS
(
		SELECT * 
		FROM 
		(
			VALUES(
			(1,'start', CAST('01-01-20' AS date)),
			(1,'cancel', CAST('01-02-20' AS date)), 
			(2,'start', CAST('01-03-20' AS date)), 
			(2,'publish', CAST('01-04-20' AS date)), 
			(3,'start', CAST('01-05-20' AS date)), 
			(3,'cancel', CAST('01-06-20' AS date)), 
			(1,'start', CAST('01-07-20' AS date)), 
			(1,'publish', CAST('01-08-20' AS date))
		)
		AS Table_1 (sender, receiver, amount, [transaction-date]) 
)























































