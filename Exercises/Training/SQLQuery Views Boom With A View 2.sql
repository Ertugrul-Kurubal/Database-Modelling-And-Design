-- Write a view to combine tables, then use this as a basis for a grouping query

--CREATE VIEW vwEverything AS 

ALTER VIEW vwEverything AS -- ALTER should use if view and its script run together after CREATE view

SELECT c.CategoryName AS Category, cont.ContinentName AS Continent,
	con.CountryName AS Country, e.EventName, e.EventDate
FROM tblCategory AS c 
	INNER JOIN tblEvent AS e ON c.CategoryID = e.CategoryID
	INNER JOIN tblCountry AS con ON con.CountryID = e.CountryID
	INNER JOIN tblContinent AS cont ON cont.ContinentID = con.ContinentID
GO

SELECT Category, COUNT(*) AS 'NumberEvents'
FROM vwEverything
WHERE Continent = 'Africa'
GROUP BY Category
ORDER BY 'NumberEvents' DESC