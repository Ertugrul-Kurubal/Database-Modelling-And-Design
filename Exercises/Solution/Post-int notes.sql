
SELECT
	e.EventName,
	e.EventDate,
	c.CountryName
FROM
	tblEvent AS e
	INNER JOIN tblCountry AS c
		ON e.CountryID = c.CountryID
WHERE
	e.EventDate > (
		SELECT MAX(ev.EventDate)
		FROM tblEvent AS ev
		WHERE ev.CountryID = 21	
	)
ORDER BY
	e.EventDate DESC

	--SELECT
	--	list of fields
	--FROM 
	--	table of events
	--WHERE
	--	Event date > (
	--		SELECT MAX(Event date)
	--		FROM table of events
	--		WHERE country id = 21
	--	)
	-- ORDER BY
	--		Event date (descending)














