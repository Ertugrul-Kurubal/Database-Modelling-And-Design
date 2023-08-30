-- Use GROUP BY and COUNT to report on the number of events for each category

SELECT cg.CategoryName,
		COUNT(*) AS 'Number of events'
FROM tblEvent AS e 
	INNER JOIN tblCategory AS cg ON e.CategoryID = cg.CategoryID
GROUP BY cg.CategoryName
ORDER BY 'Number of events' DESC