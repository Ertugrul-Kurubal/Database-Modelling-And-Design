-- Use IF to change the SELECT statement that a stored proc runs

CREATE PROC uspInformation(@Information VARCHAR(50))
AS

IF @Information = 'Event'
	BEGIN
		SELECT TOP 2
			EventName, EventDetails, EventDate
		FROM
			tblEvent
	END

IF @Information = 'Country'
	BEGIN
		SELECT TOP 2
			CountryName
		FROM
			tblCountry
	END

IF @Information = 'Continent'
	BEGIN
		SELECT TOP 2
			ContinentName
		FROM
			tblContinent
	END

------------------------------------------------------------------

EXEC uspInformation 'Event'

EXEC uspInformation 'Country'

EXEC uspInformation 'Continent'