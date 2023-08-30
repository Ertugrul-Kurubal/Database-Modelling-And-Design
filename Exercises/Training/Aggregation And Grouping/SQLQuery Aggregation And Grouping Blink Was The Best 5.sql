-- Use grouping to show how many episodes each Doctor Who author wrote

SELECT a.AuthorName, COUNT(*) AS 'Episodes',
		MIN(e.EpisodeDate) AS 'Earliest date',
		MAX(e.EpisodeDate) AS 'Latest date'
FROM tblEpisode AS e
INNER JOIN tblAuthor AS a ON e.AuthorId = a.AuthorId
GROUP BY a.AuthorName
ORDER BY 'Episodes' DESC