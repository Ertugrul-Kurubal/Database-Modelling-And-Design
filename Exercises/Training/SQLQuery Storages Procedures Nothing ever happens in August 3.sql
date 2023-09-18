-- Filter the select statement, only show events occuring in August.

CREATE PROC uspAugustEvents 
AS
SELECT e.EventID, e.EventName, e.EventDetails, e.EventDate
FROM tblEvent AS e
WHERE MONTH(e.EventDate) = 8 --DATENAME(MM,EventDate) LIKE 'August'