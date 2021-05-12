

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

SELECT  CASE
		WHEN a.[user] IS NULL THEN b.[user] ELSE a.[user]  END as [user],
		CASE
		WHEN a.[user] = b.[user] THEN credit - debit ELSE CASE WHEN a.[user] IS NULL THEN credit ELSE -debit END END as Net_Change
FROM debit a
		FULL OUTER JOIN credit b
		ON a.[user] = b.[user]
		ORDER BY Net_Change DESC

--Q2

WITH attendance  AS
(
		SELECT * 
		FROM 
		(
			VALUES
			(1, CAST('04-03-20' AS date), 0),
			(2, CAST('04-03-20' AS date), 1), 
			(3, CAST('04-03-20' AS date), 1), 
			(1, CAST('04-04-20' AS date), 1), 
			(2, CAST('04-04-20' AS date), 1), 
			(3, CAST('04-04-20' AS date), 1), 
			(1, CAST('04-05-20' AS date), 0),
			(2, CAST('04-05-20' AS date), 1),
			(3, CAST('04-05-20' AS date), 1),
			(4, CAST('04-05-20' AS date), 1)
			)
		AS Table_1 (student_id, school_date, [attendance]) 
),
students AS
		(
		SELECT *
		FROM
		(
			VALUES
			(1, 2, 5, CAST('04-03-12' AS date)),
			(2, 1, 4, CAST('04-04-13' AS date)),
			(3, 1, 3, CAST('04-05-14' AS date)),
			(4, 2, 4, CAST('04-03-13' AS date))
			)
		AS Table_2 (student_id, school_id, grade_level, date_of_birth)
)

/*SELECT b.student_id, a.attendance, b.school_id, b.grade_level, a.school_date, b.date_of_birth
FROM attendance a 
RIGHT JOIN students b
ON a.student_id = b.student_id
*/

/*
SELECT 
	COUNT(DISTINCT a.student_id) AS all_students
	, COUNT(DISTINCT CASE WHEN a.attendance THEN a.student_id END) AS bday_students
	, bday_students/all_students AS perc_bday_attendance
FROM attendance a
LEFT JOIN students b ON a.student_id = b.student_id
AND DAY(l1.date_of_birth) = DAY(l2.school_date)
AND MONTH(l1.date_of_birth) = MONTH(l2.school_date)
*/

SELECT 
	COUNT(DISTINCT a.student_id) AS cnt_std
	, COUNT(DISTINCT CASE WHEN DAY(b.date_of_birth) = DAY(a.school_date)
      AND MONTH(b.date_of_birth) = MONTH(a.school_date)
      AND a.[attendance] = 1 THEN a.student_id END) AS cnt_std_bday
	, ROUND(cnt_std_bday/cnt_std, 2) AS perc_std_attendance
FROM attendance a
LEFT JOIN students b ON a.student_id = b.student_id

























































