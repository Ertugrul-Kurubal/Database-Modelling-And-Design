-- Create a list variable to store all the events released in a specified year.

DECLARE @EventsInYear VARCHAR(MAX) = ''

SELECT TOP(3)  
	@EventsInYear = @EventsInYear + EventName + ', ' 
FROM tblEvent
WHERE YEAR(EventDate) = 1992
ORDER BY EventName ASC

IF LEN(@EventsInYear) = 0
	SELECT 'No events in year'
ELSE 
	BEGIN
		SET @EventsInYear = LEFT(@EventsInYear,LEN(@EventsInYear)-1) -- delete last comma
		SELECT @EventsInYear AS 'Eventful year'
	END