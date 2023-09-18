-- Write a basic procedure to list countries in Asia, then make small changes to it

CREATE PROC uspCountriesAsia
AS 
SELECT co.CountryID, co.CountryName 
FROM tblCountry AS co 
	--INNER JOIN tblContinent AS ct ON co.ContinentID = ct.ContinentID
WHERE co.ContinentID = 1 --ct.ContinentName = 'Asia'
ORDER BY co.CountryName