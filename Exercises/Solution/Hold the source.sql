
-- switch to the right database
USE Movies_02
GO

-- now create a query to list the films in order
SELECT
	f.Title,
	s.Source
FROM 
	Film AS f

	-- link to the table of sources for each film
	JOIN Source AS s ON f.SourceID = s.SourceID
WHERE
	-- show the ones where the source is NA
	s.Source = 'NA'
ORDER BY
	f.Title

