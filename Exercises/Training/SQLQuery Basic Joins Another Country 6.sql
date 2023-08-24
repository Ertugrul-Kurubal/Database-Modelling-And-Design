-- Use an outer join and criterion to list out the countries which have no corresponding events

SELECT b.CountryName
FROM tblEvent AS a RIGHT JOIN tblCountry b
ON a.CountryID = b.CountryID
WHERE a.EventID is NULL
