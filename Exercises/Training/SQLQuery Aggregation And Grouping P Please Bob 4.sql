-- Combine CAST, AVG, COUNT, LEN, UPPER and LEFT to show the average length of event names by category initial

SELECT UPPER(LEFT(cg.CategoryName,1)) AS 'Category initial',
		COUNT(*) AS 'Number of events', 
		FORMAT(AVG(CAST(LEN(e.EventName) AS float)),'0.00') AS 'Average event name length'
FROM tblEvent AS e
		INNER JOIN  tblCategory AS cg ON e.CategoryID = cg.CategoryID
GROUP BY UPPER(LEFT(cg.CategoryName,1))

ORDER BY
	'Category initial'
