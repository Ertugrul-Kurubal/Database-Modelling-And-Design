

DECLARE @EventsInYear varchar(max) = '' -- Create the variable to hold the list

SELECT TOP 3
	 --Set the variable equal to itself plus the eventname and a comma
	@EventsInYear = @EventsInYear + EventName + ', '
	--@EventsInYear += EventName + ', ' += is the same as saying set = to itself plus that thing
FROM
	tblEvent
WHERE
	year(EventDate) = 1992 -- put in your own year
ORDER BY
	EventName ASC

-- remove the trailing comma
IF LEN(@EventsInYear) = 0 
	SELECT 'No events in year'
ELSE
	BEGIN
		SET @EventsInYear = LEFT(@EventsInYear,LEN(@EventsInYear)-1)
		SELECT @EventsInYear AS 'Eventful year' -- if this is NULL it could be the intial variable value was NULL and anything plus NULL is NULL
	END