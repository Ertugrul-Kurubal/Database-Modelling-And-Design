-- Use two subqueries to list all events in neither the last 30 countries or the last 15 categories

SELECT e.EventName, e.EventDetails 
FROM tblEvent AS e
WHERE (e.CountryID NOT IN
				(SELECT TOP(30) c.CountryID FROM tblCountry AS c						
				ORDER BY c.CountryName DESC)) 
				AND 
				(e.CategoryID NOT IN 
				(SELECT TOP(15) cg.CategoryID FROM tblCategory AS cg
				ORDER BY cg.CategoryName DESC))
ORDER BY e.EventDate