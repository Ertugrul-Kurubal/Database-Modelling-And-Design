-- Use inner joins to link four tables to show Dr Who enemies by author

USE DoctorWho

SELECT a.Title, b.AuthorName, d.EnemyName FROM tblEpisode AS a 
INNER JOIN tblAuthor AS b ON a.AuthorId = b.AuthorId
INNER JOIN tblEpisodeEnemy AS c ON a.EpisodeId = c.EpisodeId 
INNER JOIN tblEnemy AS d ON c.EnemyId = d.EnemyId
WHERE d.EnemyName LIKE '%Dalek%'