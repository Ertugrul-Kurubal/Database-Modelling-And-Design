-- Use an inner join to link two tables together in a query

SELECT tblAuthor.AuthorName, tblEpisode.Title, tblEpisode.EpisodeType
FROM  tblAuthor INNER JOIN
      tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
WHERE (tblEpisode.EpisodeType LIKE '%special%')
ORDER BY tblEpisode.Title