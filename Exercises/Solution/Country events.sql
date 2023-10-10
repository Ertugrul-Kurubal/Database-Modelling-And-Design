CREATE PROC usp_Country_Events
(@Country VARCHAR(100)) -- Parameters are created just after the proc name in a set of brackets.
AS
--Select information about all countries
SELECT
	EventName
	,EventDate
	,CountryName
FROM
	tblEvent AS E INNER JOIN
	tblCountry AS C ON E.CountryID = C.CountryID
WHERE --Filter to coutnries matching the parameter value
	CountryName LIKE '%' + @Country + '%' --Parameters act just like variables!