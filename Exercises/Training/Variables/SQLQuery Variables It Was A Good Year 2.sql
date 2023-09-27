-- Filtering a stored procedure using variables.

USE WorldEvents
GO

CREATE PROC ItWasAGoodYear 
AS
DECLARE @FirstDay DATETIME = '01 jan 1991'
DECLARE @LastDay DATETIME = '31 dec 1991'

--EXEC ItWasAGoodYear

SELECT e.EventName, e.EventDate, c.CountryName
FROM tblEvent AS e INNER JOIN tblCountry AS c
					ON e.CountryID = c.CountryID
WHERE e.EventDate BETWEEN @FirstDay AND @LastDay