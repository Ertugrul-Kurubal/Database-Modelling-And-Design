-- Use an output parameter to return a list variable of the most eventful continents

CREATE PROC ContinentsWith50Events(
@ContinentList VARCHAR(MAX) = '' OUTPUT)
AS

SELECT
	@ContinentList += 
	ContinentName + ', '
FROM
	tblEvent AS e INNER JOIN
	tblCountry AS c ON e.CountryID = c.CountryID INNER JOIN
	tblContinent AS con ON con.ContinentID = c.ContinentID
GROUP BY
	ContinentName
HAVING
	COUNT(EventID) > 50 

----------------------------------------------------------------------

DECLARE @ListOfContinents VARCHAR(MAX) = '' 
EXEC ContinentsWith50Events @ContinentList = @ListOfContinents OUTPUT

SELECT LEFT(@ListOfContinents, LEN(@ListOfContinents)-1) AS 'Big happenings'
