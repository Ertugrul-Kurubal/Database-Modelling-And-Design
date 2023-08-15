-- Create a query containing a join to list out those films whose source is NA

SELECT a.Title, b.Source 
FROM Film a JOIN Source b ON a.SourceID = b.SourceID
WHERE b.Source = 'NA'
ORDER BY a.Title