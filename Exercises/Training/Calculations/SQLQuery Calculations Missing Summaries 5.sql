-- Use IsNull, Coalesce and/or CASE WHEN to replace nulls with values

SELECT c.ContinentName, c.Summary, 
		ISNULL(c.Summary,'No summary') AS 'Using ISNULL',
		COALESCE(c.Summary,'No summary') AS 'Using COALESCE',
		CASE 
			WHEN c.Summary IS NOT NULL THEN c.Summary
			ELSE 'No summary'
		END AS 'Using CASE'
FROM tblContinent AS c