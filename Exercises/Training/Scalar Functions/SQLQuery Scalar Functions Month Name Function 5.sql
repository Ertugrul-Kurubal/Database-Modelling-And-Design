-- Create a function to take in any month number and return the month name

USE WorldEvents
GO

CREATE FUNCTION MonthName (@MonthNumber INT)
RETURNS VARCHAR(10)
AS
BEGIN
	RETURN 
		DATENAME(MM,'2017-' + CAST(@MonthNumber AS VARCHAR(2)) + '-01')
END

------------------------------------------------------

DECLARE @Counter INT = 1 
WHILE @Counter <= 12
BEGIN
PRINT
	dbo.MonthName(@COUNTER) 

SET @Counter +=1
END