--Assignment-2

--Q1

CREATE TABLE #Assignment2
(
sender_id int,
receiver_id int,
amount int,
transaction_date date
)
;
INSERT #Assignment2 VALUES
(5, 2, 10, '02-12-20'),
(1, 3, 15, '02-13-20'),
(2, 1, 20, '02-13-20'),
(2, 3, 25, '02-14-20'),
(3, 1, 20, '02-15-20'),
(3, 2, 15, '02-15-20'),
(1, 4, 5,  '02-16-20')

--User'larýn hesabýna yatýrýlan miktar

SELECT receiver_id, sum(amount) rec_amount
FROM #Assignment2
GROUP BY receiver_id

--User'larýn hesabýndan gönderilen miktar

SELECT sender_id, sum(amount) send_amount
FROM #Assignment2
GROUP BY sender_id


SELECT COALESCE(receiver_id, sender_id) AS [user],
		COALESCE(rec_amount, 0) - COALESCE(send_amount, 0) as net_change
FROM 
(
SELECT receiver_id, sum(amount) rec_amount
FROM #Assignment2
GROUP BY receiver_id
) A
FULL OUTER JOIN
(
SELECT sender_id, sum(amount) send_amount
FROM #Assignment2
GROUP BY sender_id
) B
ON 
A.receiver_id = B.sender_id
ORDER BY 
		net_change DESC

--Q2

WITH Attendance  AS
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
		AS Table_1 (Student_id, School_date, Attendance) 
),
Std_birth AS
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
		AS Table_2 (Student_id, School_id, Grade_level, DateOfBirth)
)
SELECT COUNT(*) total_att, SUM(Attendance) birth_att, CAST(1.0*SUM(Attendance)/COUNT(*) AS decimal (3,2)) Attendance_rate
FROM Attendance A, Std_birth B
WHERE A.Student_id = B.Student_id AND
		MONTH(A.School_date) = MONTH(B.DateOFBirth) AND
		DAY(A.School_date) = DAY(B.DateOFBirth)