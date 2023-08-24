
-- list countries with no events
SELECT
	cy.CountryName
FROM
	tblCountry AS cy
	LEFT OUTER JOIN tblEvent AS e
		ON cy.CountryID = e.CountryID
WHERE
	e.EventID is null
