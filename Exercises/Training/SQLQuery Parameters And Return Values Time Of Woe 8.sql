-- Return a continent name from one procedure, and pass the output value into another

CREATE PROC uspProcedure1
			(@FirstContinent VARCHAR(100) = NULL OUTPUT)
AS

SELECT TOP 1
	@FirstContinent =  ContinentName

FROM
	tblEvent AS e INNER JOIN 
	tblCountry AS c ON e.CountryID = c.CountryID INNER JOIN
	tblContinent AS ct ON ct.ContinentID = c.ContinentID
ORDER BY
	EventDate ASC

----------------------------------------------------------

CREATE PROC uspProcedure2
			(@ContinentName VARCHAR(100))
AS
SELECT
	e.EventName
	,e.EventDate
	,ct.ContinentName
FROM
	tblEvent AS e INNER JOIN 
	tblCountry AS c ON e.CountryID = c.CountryID INNER JOIN
	tblContinent AS ct ON ct.ContinentID = c.ContinentID
WHERE
	ContinentName = @ContinentName

------------------------------------------------------------

DECLARE @Variable VARCHAR(100) = ''

EXEC uspProcedure1
@FirstContinent = @Variable OUTPUT

EXEC uspProcedure2
@ContinentName = @Variable