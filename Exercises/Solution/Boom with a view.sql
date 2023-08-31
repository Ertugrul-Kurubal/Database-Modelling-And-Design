

-- need to change ALTER to CREATE when running this for the first time
ALTER VIEW vwEverything
AS

-- create a view combining the most useful columns from 4 tables
SELECT
	cat.CategoryName AS Category,
	cn.ContinentName AS Continent,
	cy.CountryName AS Country,
	e.EventName,
	e.EventDate
FROM
	tblCategory AS cat
	INNER JOIN tblEvent AS e ON cat.CategoryID = e.CategoryID
	INNER JOIN tblCountry AS cy ON e.CountryID = cy.CountryID
	INNER JOIN tblContinent AS cn ON cy.ContinentID = cn.ContinentID
GO

-- use this view to show results
SELECT
	Category,
	COUNT(*) AS NumberEvents
FROM 
	vwEverything
WHERE
	Continent = 'Africa'
GROUP BY 
	Category
ORDER BY 
	NumberEvents DESC
