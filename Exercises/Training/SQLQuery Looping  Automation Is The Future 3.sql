-- Use a loop to show a comma-delimited list of all the films released in each month

DECLARE @FirstMonth INT = 1
DECLARE @LastMonth INT = 12

WHILE @FirstMonth <= @LastMonth	
	BEGIN
		DECLARE @EventList VARCHAR(MAX) = ''
		SELECT @EventList += EventName + ', ' FROM tblEvent WHERE MONTH(EventDate) = @FirstMonth 
		PRINT 'Events which occurred in ' + DATENAME(MM, '2017-' + CAST(@FirstMonth AS VARCHAR(2)) + '-01') + ': ' + @EventList
	SET @FirstMonth += 1 
END