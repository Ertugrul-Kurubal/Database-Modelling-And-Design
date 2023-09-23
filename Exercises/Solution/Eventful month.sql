

DECLARE @EventsInMonth varchar(max) = '' -- Create the variable to hold the list

SELECT top 3
	 --Set the variable equal to it's self plus the eventname and a comma
	@EventsInMonth =@EventsInMonth + EventName + ', '
	--@EventsInMonth += EventName + ', ' += is the same as saying set = to itself plus that thing
FROM
	tblEvent
WHERE
	Month(EventDate) = 4 -- put in your own month

SELECT
	@EventsInMonth AS 'Eventful month' -- if this is NULL it could be the intial variable value was NULL and anything plus NULL is NULL