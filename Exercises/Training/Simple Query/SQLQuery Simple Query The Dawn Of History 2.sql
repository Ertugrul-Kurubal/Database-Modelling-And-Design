-- Write a query to show the first 5 events (in date order) from the tblEvent table:
-- You should give the columns aliases (What and Details in this case);
-- Use SELECT TOP 5 to limit the results to 5 rows;
-- Even though you're sorting by the event date, it doesn't have to be included in your results.
SELECT TOP 5
	e.EventName AS 'What',
	e.EventDetails AS 'Details'
FROM
	tblEvent AS e
ORDER BY
	e.EventDate ASC
