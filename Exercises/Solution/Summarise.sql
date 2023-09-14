
alter PROC spSummariseEpisodes
AS

-- show number of episodes for each companion
SELECT TOP 3
	c.CompanionName,
	COUNT(*) AS Episodes
FROM
	tblCompanion AS c
	INNER JOIN tblEpisodeCompanion AS ec on c.CompanionId = ec.CompanionId
GROUP BY
	c.CompanionName
ORDER BY
	Episodes DESC
	
-- show number of episodes for each enemy
SELECT TOP 3
	e.EnemyName,
	COUNT(*) AS Episodes
FROM
	tblEnemy AS e
	INNER JOIN tblEpisodeEnemy AS ee on e.EnemyId = ee.EnemyId
GROUP BY
	e.EnemyName
ORDER BY
	Episodes DESC
