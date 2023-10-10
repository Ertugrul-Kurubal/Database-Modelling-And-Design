--This stored procedure generates a list of continents. Then exports them via an output parameter to be used for other nefarious purposes.

CREATE PROC uspContinentsWith50Events
(@ContinentList VARCHAR(MAX) = '' OUTPUT)

AS

SELECT
	@ContinentList += -- += is the equivilent of saying @Variable = @Variable + Value
	ContinentName + ', '
	

FROM
	tblEvent AS E INNER JOIN
	tblCountry AS C ON E.CountryID = C.CountryID INNER JOIN
	tblContinent AS CO ON CO.ContinentID = C.ContinentID
GROUP BY
	ContinentName
HAVING
	COUNT(EventID) > 50 -- Remember to use HAVING when filtering with Aggregates

---------------------RUN IN A SEPERATE SCRIPT---------------------------


DECLARE @ListOfContinents VARCHAR(MAX) = ''  -- Store the outputted list variable in a new variable.
EXEC uspContinentsWith50Events @ContinentList = @ListOfContinents OUTPUT

select left(@ListOfContinents, len(@ListOfContinents)-1) AS 'Big happenings' -- Remove that pesky trailing comma