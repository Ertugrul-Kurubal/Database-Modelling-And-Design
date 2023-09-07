

-- list out all events where ...
SELECT
	e.EventName,
	e.EventDetails
FROM
	tblEvent AS e
WHERE
	-- ... the country for the event isn't in the last 30 in alphabetical order and ...
	e.CountryID NOT IN (
		SELECT TOP 30 c.CountryID
		FROM tblCountry AS c
		ORDER BY c.CountryName DESC
	) 
	-- the category isn't in the last 15 in alphabetical order
	and e.CategoryID NOT IN (
		SELECT TOP 15 c.CategoryID
		FROM tblCategory AS c
		ORDER BY c.CategoryName DESC
	)
ORDER BY
	e.EventDate
