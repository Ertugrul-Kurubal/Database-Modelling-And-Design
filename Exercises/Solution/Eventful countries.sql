
-- show countries ...
SELECT
	c.CountryName
FROM
	tblCountry AS c
WHERE
	(
		-- ... which have more than 8 events
		SELECT COUNT(*)
		FROM tblEvent AS e
		WHERE e.CountryID = c.CountryID
	) > 8
ORDER BY 
	c.CountryName