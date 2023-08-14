-- Display full dates, including the correct suffix (1st, 2nd, 3rd, etc)

SELECT EventName, 
	DATENAME(WEEKDAY,EventDate) + ' ' +
	DATENAME(DAY, EventDate) + 
	CASE
		WHEN DATEPART(DAY, EventDate) IN (1,21,31) THEN 'st'
		WHEN DATEPART(DAY, EventDate) IN (2,22) THEN 'nd'
		WHEN DATEPART(DAY, EventDate) IN (3,23) THEN 'rd'
		ELSE 'th'
	END + ' ' +
	DATENAME(MONTH,EventDate) + ' ' +
	DATENAME(YEAR,EventDate) AS 'Full date'
FROM tblEvent
ORDER BY EventDate ASC

