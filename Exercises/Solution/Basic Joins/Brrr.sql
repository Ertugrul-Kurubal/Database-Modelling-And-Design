
SELECT

	-- show fields from 3 different tables
	ev.EventName,
	ev.EventDate,
	cy.CountryName,
	cn.ContinentName

FROM
	tblContinent AS cn
	
	-- join to countries
	INNER JOIN tblCountry as cy
		ON cn.ContinentID = cy.ContinentID

	-- join to events
	INNER JOIN tblEvent as ev
		ON cy.CountryID = ev.CountryID
		
WHERE
	-- Antarctic continent or Russia country
	cn.ContinentName = 'Antarctic' or
	cy.CountryName = 'Russia'