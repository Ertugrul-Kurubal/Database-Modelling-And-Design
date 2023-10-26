-- Return from a stored proecure the name of the country with the most events and how many events there were

/*CREATE PROC uspMostNumerous*/
ALTER PROC uspMostNumerous
			(@TopCountry VARCHAR(100) = NULL OUTPUT,
			@EventCount INT  = NULL OUTPUT)
AS

SELECT TOP 1
	@TopCountry = CountryName,
	@EventCount= COUNT(e.CountryID) 
FROM
	tblEvent AS e INNER JOIN
	tblCountry AS c ON e.CountryID = c.CountryID
GROUP BY
	CountryName
ORDER BY
	COUNT(e.CountryID) DESC

-----------------------------------------------------------

DECLARE @CountryVariable VARCHAR(100) 
DECLARE @EventCountVariable INT

EXEC uspMostNumerous
	@TopCountry = @CountryVariable OUTPUT,
	@EventCount = @EventCountVariable OUTPUT 

SELECT
	@CountryVariable as 'Country of interest', @EventCountVariable
