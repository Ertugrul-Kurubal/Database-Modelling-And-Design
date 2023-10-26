-- Filter in a stored procedure using a parameter

CREATE PROC uspCountryEvents
(@CountryName VARCHAR(100)) 
AS

SELECT
	EventName
	,EventDate
	,CountryName
FROM
	tblEvent AS e INNER JOIN
	tblCountry AS c ON e.CountryID = c.CountryID
WHERE
	CountryName LIKE '%' + @CountryName + '%' 

---------------------------------------------------------------

EXEC uspCountryEvents 'Germany'