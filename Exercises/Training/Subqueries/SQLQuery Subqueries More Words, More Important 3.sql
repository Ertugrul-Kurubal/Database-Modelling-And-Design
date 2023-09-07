-- Use subqueries to filter with aggregates

SELECT TOP(5) e.EventName
FROM (SELECT EventName 
		FROM tblEvent
		WHERE LEN(EventName) > (SELECT AVG(LEN(EventName))
								FROM tblEvent)) AS e

/*
SELECT AVG(LEN(EventName)) AS [Average length]
FROM tblEvent
*/