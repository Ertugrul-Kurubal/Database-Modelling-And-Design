
ALTER PROC uspContinentEvents
(@ContinentName varchar(100)  = '' --The empty string will be concatenated onto % wild cards. This will return all the values
,@StartDate DATETIME = '1753-01-01' -- Earliest date recognised by SQL unless using datetime2 01-01-01
,@EndDate DATETIME = '9999-12-31') -- Latest date recognised in sql due to 4 year character limitations
AS

SELECT
	C.ContinentName
	,E.EventName
	,E.EventDate
FROM
	tblEvent AS E INNER JOIN
	tblCountry AS CY ON CY.CountryID = E.CountryID INNER JOIN
	tblContinent AS C ON C.ContinentID = CY.ContinentID
WHERE
	ContinentName LIKE '%' + @ContinentName + '%' AND --Using wild card like % or _ will allow more results to be returend
	EventDate > @StartDate AND
	EventDate < @EndDate