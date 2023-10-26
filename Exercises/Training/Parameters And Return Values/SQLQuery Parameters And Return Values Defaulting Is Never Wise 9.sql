-- Create stored procedures with default values for the parameters
USE WorldEvents
GO

CREATE PROC uspContinentEvents (@ContinentName VARCHAR(50) = '',
			@AfterDate DATETIME = '1753-01-01', 
			@BeforeDate DATETIME = '9999-12-31')
AS

SELECT 
	ct.ContinentName, e.EventName, e.EventDate
FROM 
	tblCountry AS co INNER JOIN tblEvent AS e ON co.CountryID = e.CountryID
	INNER JOIN tblContinent AS ct ON ct.ContinentID = co.ContinentID
WHERE
	(ct.ContinentName LIKE '%' + @ContinentName + '%') AND
	(@AfterDate < e.EventDate) AND
	(@BeforeDate > e.EventDate)

------------------------------------------------------------------

EXEC uspContinentEvents
