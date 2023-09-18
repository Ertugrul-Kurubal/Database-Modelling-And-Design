-- Create a stored procedure to list Dr Who episodes by frequency in two ways

CREATE PROC spSummariseEpisodes
AS
SELECT TOP(3) c.CompanionName, COUNT(*) AS 'Episodes'
FROM tblCompanion AS c
	INNER JOIN tblEpisodeCompanion AS ec ON c.CompanionId = ec.CompanionId
GROUP BY c.CompanionName
ORDER BY 'Episodes' DESC

SELECT TOP(3) en.EnemyName, COUNT(*) AS 'Episodes'
FROM tblEnemy AS en
	INNER JOIN tblEpisodeEnemy AS ee ON en.EnemyId = ee.EnemyId
GROUP BY en.EnemyName
ORDER BY 'Episodes' DESC

EXEC spSummariseEpisodes

ALTER PROC spSummariseEpisodes
AS
SELECT TOP(5) c.CompanionName, COUNT(*) AS 'Episodes'
FROM tblCompanion AS c
	INNER JOIN tblEpisodeCompanion AS ec ON c.CompanionId = ec.CompanionId
GROUP BY c.CompanionName
ORDER BY 'Episodes' DESC

SELECT TOP(5) en.EnemyName, COUNT(*) AS 'Episodes'
FROM tblEnemy AS en
	INNER JOIN tblEpisodeEnemy AS ee ON en.EnemyId = ee.EnemyId
GROUP BY en.EnemyName
ORDER BY 'Episodes' DESC

EXEC spSummariseEpisodes