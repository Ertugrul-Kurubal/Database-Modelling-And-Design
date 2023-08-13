-- Use the DATENAME and DATEPART functions to show events taking place on Friday 13th of any month/year

SELECT EventName, EventDate, 
DATENAME(WEEKDAY, EventDate) AS 'Day of week',
DAY(EventDate) AS 'Day number'
FROM tblEvent
WHERE DATENAME(WEEKDAY, EventDate) = 'Saturday' and DAY(EventDate) = 14