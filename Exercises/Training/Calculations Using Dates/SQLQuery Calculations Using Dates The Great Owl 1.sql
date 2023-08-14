-- Combine the YEAR, CONVERT and FORMAT functions to show events in your year of birth

SELECT EventName, EventDate AS 'NotFormatted',
	FORMAT(EventDate, 'dd/MM/yyyy') AS 'UsingFormat',
	CONVERT(char(10), EventDate, 103) AS 'UsingConvert'
FROM tblEvent
WHERE YEAR(EventDate) = 1990
ORDER BY EventDate ASC