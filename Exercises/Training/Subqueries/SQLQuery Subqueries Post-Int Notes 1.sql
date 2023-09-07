-- Use a subquery to show events which happened since the last one for a particular country occurred

SELECT e.EventName, e.EventDate, c.CountryName
FROM tblEvent AS e 
	INNER JOIN tblCountry AS c ON e.CountryID = c.CountryID
WHERE e.EventDate > (SELECT MAX(EventDate) 
					FROM tblEvent
					WHERE CountryID = 21)
ORDER BY EventDate DESC