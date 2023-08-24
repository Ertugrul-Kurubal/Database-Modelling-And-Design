-- the query, tidied up
SELECT 
	tblAuthor.AuthorName, 
	tblEpisode.Title, 
	tblEpisode.EpisodeType
FROM     
	tblAuthor 
	INNER JOIN tblEpisode ON 
		tblAuthor.AuthorId = tblEpisode.AuthorId
WHERE  
	tblEpisode.EpisodeType LIKE '%special%'
ORDER BY 
	tblEpisode.Title
