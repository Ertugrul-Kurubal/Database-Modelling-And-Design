

CREATE TABLE Person_Book
(
Person_ID BIGINT Not Null,
Book_ID INT Not Null
)
;
--Comment
/*
Comment*/

CREATE TABLE [SAMPLE]  --SAMPLE is reserved SQL library

--ALTER

ALTER TABLE Person_Book ADD Book_Name nvarchar(100)

ALTER TABLE Person_Book ALTER COLUMN Book_Name nvarchar(80)

ALTER TABLE Person_Book DROP COLUMN Book_Name

SELECT * FROM Person_Book

--DROP

DROP TABLE Person_Book;

DROP TABLE IF EXISTS Person_Book

INSERT Person_Book VALUES (54365486978, 1234567892), (54365486977, 1234567891)

--TRUNCATE

TRUNCATE TABLE Person_Book

--DELETE

DELETE FROM Person_Book WHERE Person_ID = 54365486978

--SELECT INTO

SELECT * INTO Person_Book_2 FROM Person_Book

--SELECT

SELECT 4 

SELECT 5 as number

SELECT 5 number 

SELECT 5 [int number] --If we use space, values use with braket

SELECT 'HELLO'

SELECT 'HEL'+'LO'+'5'

SELECT 'HEL'+'LO'+'5', 4+5 TOTAL, 4*5

SELECT Person_ID+Book_ID,Person_ID,Book_ID
FROM Person_Book

SELECT 'Person_ID'+'Book_ID',Person_ID,Book_ID
FROM Person_Book

SELECT CONVERT (CHAR(11), Person_ID) + ' '+ CONVERT (CHAR(10), Book_ID),Person_ID,Book_ID
FROM Person_Book

SELECT CONVERT (CHAR(11), Person_ID) + '/'+ CONVERT (CHAR(10), Book_ID),Person_ID,Book_ID
FROM Person_Book

SELECT CAST (Person_ID AS CHAR(11)) + '/'+ CAST (Book_ID AS CHAR(10)),Person_ID,Book_ID
FROM Person_Book

--INSERT

SELECT * FROM Author

SELECT * FROM Book

SELECT TOP (1000) [Publisher_ID],[Publisher_Name]
FROM [MFDatabase].[dbo].[Publisher]
