ALTER PROC uspCountriesAsia
AS

-- list countries in Asia
SELECT
	c.CountryId,
	c.CountryName
FROM
	tblCountry AS c
WHERE	
	c.ContinentID = 1
ORDER BY 
	c.CountryName
GO

-- test this
uspCountriesAsia