-- Create an inner join in a query, then change it to an outer join to show categories having no events

-- SELECT e.EventName, e.EventDate, c.CategoryName
-- FROM tblEvent AS e INNER JOIN tblCategory AS c
-- ON e.CategoryID = c.CategoryID
-- ORDER BY e.EventDate DESC

SELECT c.CategoryName
FROM tblEvent AS e FULL OUTER JOIN tblCategory AS c
ON e.CategoryID = c.CategoryID
WHERE e.EventName IS NULL
ORDER BY e.EventDate DESC