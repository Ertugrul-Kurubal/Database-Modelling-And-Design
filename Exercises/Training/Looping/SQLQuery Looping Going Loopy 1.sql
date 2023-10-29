-- Create a loop to perform a count for each year of a given range

DECLARE @StartValue INT = 1981

DECLARE @EndValue INT = 2017

WHILE @StartValue <= @EndValue
	BEGIN
		DECLARE @CountEvents INT = (SELECT COUNT(*) FROM tblEvent WHERE YEAR(EventDate) = @StartValue) 
		PRINT CAST(@CountEvents AS VARCHAR(4)) + ' events occurred in ' + CAST(@StartValue AS VARCHAR(4))
	SET @StartValue += 1 

END