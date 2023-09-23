

CREATE PROC ItWasAGoodYear 
AS
DECLARE @FirstDay datetime = '01 jan 1991' --First day of year of birth
DECLARE @LastDay datetime = '31 dec 1991' -- Last day of year of birth

--Bring information about events in that year through.
SELECT
	EventName
	,EventDate
	,CountryName
FROM
	tblCountry AS C INNER JOIN tblEvent AS E ON E.CountryID = C.CountryID
WHERE
	EventDate BETWEEN @FirstDay AND @LastDay --Filter between first day of year and last day of year.