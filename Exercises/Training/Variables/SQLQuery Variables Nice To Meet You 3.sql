-- Declare 3 variables to hold different data types

USE Websites
GO

DECLARE @BornDate DATETIME = '01/05/1991'
DECLARE @MyName VARCHAR(30) = 'Ertuðrul'
DECLARE @PetNums INT = 0

SELECT 'My name is ' + @MyName + ', I was born on ' + 
		CONVERT(VARCHAR(50),@BornDate,103) + ' and I have ' + 
		CAST(@PetNums AS VARCHAR(50))+ ' pets' AS 'Fun facts'

/*
DECLARE @Variable1 DataType = 'Your Name'
SET @Variable2 = 'Your dob'
SELECT @Variable3 = 'Your number of pets'
*/