-- Use views based on views to show Doctor Who episodes with only 1 enemy and 1 companion

USE DoctorWho
GO

/*
CREATE VIEW vwEpisodeCompanion AS 
SELECT 
	e.EpisodeId,
	e.Title,
	COUNT(*) as NumberEpisodes
FROM tblEpisode AS e
		INNER JOIN tblEpisodeCompanion AS ec ON e.EpisodeId = ec.EpisodeId
GROUP BY e.EpisodeId, e.Title
HAVING COUNT(*) = 1
GO

CREATE VIEW vwEpisodeEnemy AS 
SELECT 
	e.EpisodeId,
	e.Title,
	COUNT(*) as NumberEpisodes
FROM tblEpisode AS e
		INNER JOIN tblEpisodeEnemy AS ee ON e.EpisodeId = ee.EpisodeId
GROUP BY e.EpisodeId, e.Title
HAVING COUNT(*) = 1
GO

CREATE VIEW vwEpisodeSummary AS 
SELECT 
	e.EpisodeId,
	e.Title
FROM tblEpisode AS e
		LEFT OUTER JOIN vwEpisodeEnemy AS ee ON e.EpisodeId = ee.EpisodeId
		LEFT OUTER JOIN vwEpisodeCompanion AS ec ON e.EpisodeId = ec.EpisodeId
WHERE
	ee.EpisodeId is null and
	ec.EpisodeId is null
GO
*/


ALTER VIEW vwEpisodeCompanion AS 
SELECT 
	e.EpisodeId,
	e.Title,
	COUNT(*) as NumberEpisodes
FROM tblEpisode AS e
		INNER JOIN tblEpisodeCompanion AS ec ON e.EpisodeId = ec.EpisodeId
GROUP BY e.EpisodeId, e.Title
HAVING COUNT(*) = 1
GO

ALTER VIEW vwEpisodeEnemy AS 
SELECT 
	e.EpisodeId,
	e.Title,
	COUNT(*) as NumberEpisodes
FROM tblEpisode AS e
		INNER JOIN tblEpisodeEnemy AS ee ON e.EpisodeId = ee.EpisodeId
GROUP BY e.EpisodeId, e.Title
HAVING COUNT(*) = 1
GO

ALTER VIEW vwEpisodeSummary AS 
SELECT 
	e.EpisodeId,
	e.Title
FROM tblEpisode AS e
		LEFT OUTER JOIN vwEpisodeEnemy AS ee ON e.EpisodeId = ee.EpisodeId
		LEFT OUTER JOIN vwEpisodeCompanion AS ec ON e.EpisodeId = ec.EpisodeId
WHERE
	ee.EpisodeId is null and
	ec.EpisodeId is null
GO

SELECT * FROM vwEpisodeSummary
ORDER BY Title