-- Use COUNT, MAX and MIN to show statistics about the rows in the events table

SELECT COUNT(*) AS 'Number of Event', 
		MAX(EventDate) AS 'Last date',
		MIN(EventDate) AS 'First date'
FROM tblEvent