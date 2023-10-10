-- Get a stored procedure to list the Dr Who episodes for a given enemy
/*CREATE PROC spEnemyEpisodes*/
ALTER PROC spEnemyEpisodes (
@EnemyName VARCHAR(50))
AS 
SELECT tblEpisode.SeriesNumber, tblEpisode.EpisodeNumber, tblEpisode.Title
FROM tblEnemy INNER JOIN tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId 
			  INNER JOIN tblEpisode ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId
WHERE tblEnemy.EnemyName LIKE '%' + @EnemyName + '%'
ORDER BY tblEpisode.SeriesNumber, tblEpisode.EpisodeNumber

GO 
spEnemyEpisodes 'dalek'