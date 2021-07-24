--MS SQL SERVER STRING FUNCTIONS

--LEN

SELECT LEN(123456789)

SELECT LEN(  123456789) -- BoþluSklarý saymýyor

SELECT LEN('WELCOME')

SELECT LEN(' WELCOME')

SELECT LEN('"WELCOME"')

--CHARINDEX

SELECT CHARINDEX('C', 'CHARACTER')

SELECT CHARINDEX('C', 'CHARACTER', 2)

SELECT CHARINDEX('c', 'CHARACTER') -- Not case sensitive

SELECT CHARINDEX('CT', 'CHARACTER')

SELECT CHARINDEX('ct', 'CHARACTER')

--PATHINDEX

SELECT PATINDEX('%R', 'CHARACTER')

SELECT PATINDEX('%R%', 'CHARACTER')

SELECT PATINDEX('R%', 'CHARACTER') -- % represent many character

SELECT PATINDEX('__A%', 'CHARACTER') -- _ represent 1 character

SELECT PATINDEX('%__T%', 'CHARACTER')

--LEFT

SELECT LEFT ('CHARACTER', 3)

SELECT LEFT ('  CHARACTER', 3)

--RIGHT

SELECT RIGHT ('CHARACTER', 3)

SELECT RIGHT ('CHARACTER ', 3)

--SUBSTRING

SELECT SUBSTRING ('CHARACTER', 3, 5)

SELECT SUBSTRING ('123456789', 3, 5)

SELECT SUBSTRING ('CHARACTER', 0, 3) -- Sýfýrýncý karakter yok

SELECT SUBSTRING ('CHARACTER', 1, 3)

SELECT SUBSTRING ('CHARACTER', -1, 3)

--LOWER

SELECT LOWER('CHARACTER')

--UPPER

SELECT LOWER('character')

SELECT LEFT ('character', 1)


SELECT UPPER(LEFT ('character', 1))+ 'haracter'

SELECT UPPER(LEFT('character',1)) + LOWER(right('character',len('character')-1))

SELECT UPPER (LEFT('character',1)) + LOWER (RIGHT ('CHARACTER', LEN('CHARACTER')-1 ))

--STRING_SPLIT

SELECT *
FROM
STRING_SPLIT('ALÝ,VELÝ,AHMET', ',')

SELECT *
FROM
STRING_SPLIT('ALÝ/VELÝ/AHMET', '/')

SELECT *
FROM
STRING_SPLIT('ALÝ//VELÝ//AHMET', '/')

--TRIM, RTRIM, LTRIM

SELECT TRIM(' CHARACTER   ')

SELECT TRIM(' CHARACT ER   ')

SELECT LTRIM(' CHARACTER   ')

SELECT RTRIM(' CHARACTER   ')

--REPLACE

SELECT REPLACE ('CHARACTER', 'RAC', '')

SELECT REPLACE ('CHARACTER', 'RAC', '/')

SELECT REPLACE('CHARACTER STRING', ' ', '')

--STR

SELECT STR (1234567)

SELECT STR (1234567890)

SELECT STR (1234, 3)

SELECT STR (1234, 4)

SELECT STR (1234, 5)

SELECT STR (1234, 6, 2)

SELECT STR (1234, 9, 3)

SELECT STR (1234.000, 8, 2)

SELECT STR (1234.123, 8, 2)

--CAST

SELECT CAST(123456 AS CHAR)

SELECT CAST(123456 AS CHAR) + 'ALÝ'

SELECT CAST(123456 AS CHAR(7)) + 'ALÝ'

SELECT GETDATE()

SELECT CAST (GETDATE() AS DATE)

--CONVERT

SELECT CONVERT(INT, 30.60)

SELECT CONVERT(FLOAT, 30.61)

SELECT CONVERT(VARCHAR(10), '2020-10-12')

--COALESCE

SELECT COALESCE(NULL, NULL, 'ALÝ', 'VALÝ', NULL)

--NULLIF

SELECT NULLIF('AHMET', 'AHMET')

SELECT NULLIF('AHMET', 'VELÝ')

SELECT NULLIF(2,'2')

SELECT COUNT(first_name)
FROM sales.customers

SELECT NULLIF(first_name, 'Debra')
FROM sales.customers

SELECT COUNT(NULLIF(first_name, 'Debra'))
FROM sales.customers

--EXERCISES

--Customer tablosunda kaç tane yahoo maili vardýr?

SELECT COUNT(*) 
FROM [sales].[customers]
WHERE email LIKE '%yahoo%'

--email sütununun deðerlerinde bulunan nokta karakterinden önceki ifadeleri getiriniz.

SELECT SUBSTRING(email, 1, CHARINDEX('.', email)-1) 
FROM [sales].[customers]

SELECT LEFT(email, CHARINDEX ('.', email)-1)
FROM
sales.customers

--her müþteriye ulaþabileceðim telefon veya email bilgisini istiyorum.
--Müþterinin telefon bilgisi varsa email bilgisine gerek yok.
--telefon bilgisi yoksa email adresi iletiþim bilgisi olarak gelsin.
--beklenen sütunlar: customer_id, first_name, last_name, contact

SELECT customer_id,first_name,last_name,
CASE WHEN phone IS NULL THEN email ELSE phone END contact
FROM [sales].[customers]

SELECT customer_id, first_name, last_name,
COALESCE(sales.customers.phone,sales.customers.email) AS contact FROM sales.customers 
-- COALESCE yazýlan deðerleri teker teker kontrol ediyor eðer ilk deðer Null ise bir sonrakine geçerek devam ediyor.

--@ iþareti ile mail sütununu ikiye ayýrýn. Örneðin
--ronna.butler@gmail.com	/ ronna.butler	/ gmail.com

SELECT email,SUBSTRING(email, 1, CHARINDEX('@', email)-1) As First_part,
		RIGHT (email,LEN(email)-CHARINDEX('@', email)) As Second_part
FROM [sales].[customers]

SELECT SUBSTRING(email, 0, CHARINDEX('@',email)) AS 'name', REPLACE(SUBSTRING(email, CHARINDEX('@',email), len(email)), '@', '') AS 'domain'
FROM sales.customers

SELECT LEFT(email, CHARINDEX('@',email)-1) [left], RIGHT(email, LEN(email) - CHARINDEX('@',email)) [right]
FROM sales.customers

SELECT SUBSTRING(email, 0, CHARINDEX('@',email)) AS 'name', SUBSTRING(email, CHARINDEX('@',email)+1, len(email)) AS 'domain'
FROM sales.customers

SELECT email,SUBSTRING(email, 1, CHARINDEX('@', email)-1) As First_part,
		SUBSTRING(email,CHARINDEX('@', email)+1,LEN(email)) As Second_part
FROM [sales].[customers]

--RAKAM ile baþlayan sokak isimlerini getiriniz

SELECT street, LEFT(street,1)
FROM [sales].[customers]
WHERE LEFT(street,1) IN (0,1,2,3,4,5,6,7,8,9)

SELECT CASE
WHEN SUBSTRING(street, 0, 1) IN (0,1,2,3,4,5,6,7,8,9) THEN street END AS streetwithnum
FROM sales.customers

SELECT street
FROM sales.customers
WHERE CONVERT(int, LEFT(street,1)) >= 0

SELECT street, SUBSTRING(street, 3, 1)
FROM [sales].[customers]
WHERE SUBSTRING(street,3,1) LIKE '[0-9]'

SELECT street, SUBSTRING(street, 3, 1)
FROM [sales].[customers]
WHERE SUBSTRING(street,3,1) NOT LIKE '[^0-9]'

SELECT street, SUBSTRING(street, 3, 1)
FROM [sales].[customers]
WHERE SUBSTRING(street,3,1) NOT LIKE '[0-9]'



