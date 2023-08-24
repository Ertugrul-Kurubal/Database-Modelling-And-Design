-- Link the continent, country and event tables with inner joins, and then filter by fields from 2 tables

SELECT a.EventName, a.EventDate, b.CountryName, c.ContinentName
FROM tblEvent a INNER JOIN tblCountry b ON a.CountryID = b.CountryID 
INNER JOIN tblContinent c ON b.ContinentID = c.ContinentID
WHERE c.ContinentName = 'Antarctic' OR b.CountryName = 'Russia' 


 
