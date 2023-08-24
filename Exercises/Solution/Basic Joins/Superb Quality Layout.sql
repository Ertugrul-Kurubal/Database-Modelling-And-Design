
-- list events, with countries
SELECT     
   
	-- fields from the country table
	cy.CountryName AS Country, 

	-- fields from the events table
	ev.EventName AS [What happened], 
	ev.EventDate AS [When happened]

FROM

	-- start with the country table ...            
	tblCountry AS cy

	-- ... and join this to the events
	INNER JOIN tblEvent AS ev
		ON cy.CountryID = ev.CountryID

ORDER BY 
	-- show in date order
	[When happened]