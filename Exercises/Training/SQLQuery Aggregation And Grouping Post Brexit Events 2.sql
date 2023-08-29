-- Use SELECT, FROM, WHERE, GROUP BY, HAVING and ORDER BY to list non-European busy countries

SELECT ct.ContinentName AS 'Continent',
		c.CountryName AS 'Country',
		COUNT(*) AS 'Number of events'
FROM tblEvent AS e
	INNER JOIN tblCountry AS c ON e.CountryID = c.CountryID
	INNER JOIN tblContinent AS ct ON c.ContinentID = ct.ContinentID
WHERE ct.ContinentName != 'Europe'
GROUP BY ct.ContinentName, c.CountryName
HAVING COUNT(*) >= 5
ORDER BY 'Number of events' DESC
