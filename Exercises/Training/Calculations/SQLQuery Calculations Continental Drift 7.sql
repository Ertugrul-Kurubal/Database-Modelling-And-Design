-- Write a CASE WHEN expression to assign countries to different groups

SELECT c.CountryName, 
		CASE 
			WHEN c.ContinentID = 1 OR c.ContinentID = 3 THEN 'Eurasia'
			WHEN c.ContinentID = 5 OR c.ContinentID = 6 THEN 'Americas'
			WHEN c.ContinentID in (2,4) THEN 'Somewhere hot'
			WHEN c.ContinentID = 7 THEN 'Somewhere cold'
			ELSE 'Somewhere else'
		END AS CountryLocation
FROM tblCountry AS c
ORDER BY CountryLocation DESC
