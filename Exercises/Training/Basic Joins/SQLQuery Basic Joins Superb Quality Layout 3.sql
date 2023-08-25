-- Create a query using the designer, joining 2 tables, then tidy it up and comment its SQL

SELECT ctry.CountryName AS Country, 
evt.EventName AS [What happened], 
evt.EventDate AS [When happened]
FROM tblCountry AS ctry INNER JOIN
     tblEvent AS evt ON ctry.CountryID = evt.CountryID
ORDER BY [When happened]