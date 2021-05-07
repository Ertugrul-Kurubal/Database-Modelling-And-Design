 
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















