
ALTER PROC spEnemyEpisodes(
	@EnemyName varchar(100)
)
AS

-- show all of the episodes featuring a particular enemy
SELECT DISTINCT
	ep.SeriesNumber,
	ep.EpisodeNumber,
	ep.Title
FROM
	tblEnemy AS e
	INNER JOIN tblEpisodeEnemy AS ee ON e.EnemyId = ee.EnemyId
	INNER JOIN tblEpisode AS ep ON ee.EpisodeId = ep.EpisodeId
WHERE
	e.EnemyName like '%' + @EnemyName + '%'
ORDER BY
	ep.SeriesNumber,
	ep.EpisodeNumber
GO

-- test this out
spEnemyEpisodes 'silence'