-- Use the DATEDIFF and the ABS functions to list the events in order of closeness to when you were born.

SELECT EventName, FORMAT(EventDate, 'dd MMM yyyy') AS 'EventDate',
		DATEDIFF(DAY, '19910501', EventDate) AS 'Days offset',
		ABS(DATEDIFF(DAY, '19910501', EventDate)) AS 'Days difference'
FROM tblEvent
ORDER BY 'Days difference' ASC