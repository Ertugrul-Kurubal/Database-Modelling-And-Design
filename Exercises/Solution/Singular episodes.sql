USE DoctorWho
GO

-- note that the ALTER words need to become CREATE

ALTER VIEW vwEpisodeCompanion
AS

-- show the episodes featuring more than one companion
SELECT
	e.EpisodeId,
	e.Title,
	COUNT(*) as NumberEpisodes
FROM
	tblEpisode AS e
	INNER JOIN tblEpisodeCompanion AS ec ON e.EpisodeId = ec.EpisodeId
GROUP BY
	e.EpisodeId,
	e.Title
HAVING
	count(*) = 1

GO

-- now do the same for episodes having more than one enemy
ALTER VIEW vwEpisodeEnemy
AS

-- show the episodes featuring more than one enemy
SELECT
	e.EpisodeId,
	e.Title,
	COUNT(*) as NumberEpisodes
FROM
	tblEpisode AS e
	INNER JOIN tblEpisodeEnemy AS ec ON e.EpisodeId = ec.EpisodeId
GROUP BY
	e.EpisodeId,
	e.Title
HAVING
	count(*) = 1

GO

-- now show the episodes which don't feature in either
ALTER VIEW vwEpisodeSummary
AS

SELECT
	e.EpisodeId,
	e.Title
FROM
	tblEpisode AS e
	LEFT OUTER JOIN vwEpisodeEnemy AS en ON e.EpisodeId = en.EpisodeId
	LEFT OUTER JOIN vwEpisodeCompanion AS c ON e.EpisodeId = c.EpisodeId
WHERE
	en.EpisodeId is null and
	c.EpisodeId is null

GO

-- test this
SELECT * FROM vwEpisodeSummary
ORDER BY 
	Title
