-- Using sub queries filter the select statement

SELECT con.ContinentName, EventName
FROM tblEvent AS e 
	INNER JOIN tblCountry AS c ON e.CountryID = c.CountryID
	INNER JOIN tblContinent AS con ON con.ContinentID = c.ContinentID
WHERE con.ContinentName IN (SELECT TOP(3) con.ContinentName
							FROM tblEvent AS e 
								INNER JOIN tblCountry AS c ON e.CountryID = c.CountryID
								INNER JOIN tblContinent AS con ON con.ContinentID = c.ContinentID
							GROUP BY con.ContinentName
							ORDER BY COUNT(e.EventName))