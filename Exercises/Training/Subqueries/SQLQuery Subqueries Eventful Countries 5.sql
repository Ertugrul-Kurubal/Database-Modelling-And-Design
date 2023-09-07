-- Create a correlated subquery to list out all countries having more than 8 events

SELECT c.CountryName 
FROM tblCountry AS c 
WHERE (SELECT COUNT(*) 
		FROM tblEvent AS e
		WHERE e.CountryID = c.CountryID) > 8
ORDER BY c.CountryName