 
 --DAwSQL Lab-1 
 --DAwSQL Assignment-1 Solution 

 WITH T1 AS (
 SELECT 1 AS NUM
 ),
 T2 AS (
 SELECT NUM*5 Result
 FROM T1
 )
 SELECT * FROM T2
 
 --Recursive
 
 WITH T1
 AS
 (
 SELECT 1 AS NUMBER
 UNION ALL
 SELECT NUMBER*2
 FROM T1
 WHERE NUMBER < 20
 )
 SELECT * FROM T1

 --Q1

 WITH T1 AS (
 SELECT 0 fact_number, 1 result
 UNION ALL
 SELECT fact_number+1, (fact_number+1)*result
 FROM T1
 WHERE fact_number < 6
 )
 SELECT result FROM T1
 WHERE fact_number=6

 --Q2
/* WITH users AS
 (
 SELECT * 
 FROM 
 (
 VALUES(
 (1, 'Start', CAST('01-01-20' AS date),
 (1, 'Cancel', CAST('01-02-20' AS date),
 (2, 'Start', CAST('01-03-20' AS date),
 (2, 'Publish', CAST('01-04-20' AS date),
 (3, 'Start', CAST('01-05-20' AS date),
 (3, 'Cancel', CAST('01-06-20' AS date),
 (1, 'Start', CAST('01-07-20' AS date),
 (1, 'Publish', CAST('01-08-20' AS date)
  AS Table_1 ([user_id], [action], [date])
 ),
 Table_2 AS 
 (
 SELECT [user_id],
  SUM(CASE WHEN [action] = 'Cancel' THEN 1 ELSE 0) as cnt_cancel,
  SUM(CASE WHEN [action] = 'Start' THEN 1 ELSE 0) as cnt_start,
  SUM(CASE WHEN [action] = 'Publish' THEN 1 ELSE 0) as cnt_publish
  ) 
  FROM 
  users
  GROUP BY [user_id]
  )
*/

WITH users (User_id, [Action], [date]) AS 
(
SELECT 1, 'Start', '2020-01-01'
UNION ALL
SELECT 1, 'Cancel','2020-02-01'
UNION ALL
SELECT 2, 'Start', '2020-03-01'
UNION ALL
SELECT 2, 'Publish', '2020-04-01'
UNION ALL
SELECT 3, 'Start', '2020-05-01'
UNION ALL
SELECT 3, 'Cancel', '2020-06-01'
UNION ALL 
SELECT 1, 'Start', '2020-07-01'
UNION ALL
SELECT 1, 'Publish', '2020-08-01'
)
SELECT User_id, 1.0*SUM([Action] = 'Publish')/SUM([Action] = 'Start') AS Publish_rate, 1.0*SUM([Action] = 'Cancel')/SUM([Action] = 'Start') AS Cancel_rate
FROM users	
GROUP BY  User_id










