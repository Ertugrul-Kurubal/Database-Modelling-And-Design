-- Use a variable holding a row id to get at the details for a row

USE DoctorWho

DECLARE @EpisodeId INT = 54

DECLARE @EpisodeName VARCHAR(50) = (
		SELECT Title 
		FROM tblEpisode
		WHERE EpisodeId = @EpisodeId
		)

DECLARE @NumberCompanions INT = (
		SELECT COUNT(*)
		FROM tblEpisodeCompanion
		WHERE EpisodeId = @EpisodeId
		)

DECLARE @NumberEnemies INT = (
		SELECT COUNT(*)
		FROM tblEpisodeEnemy
		WHERE EpisodeId = @EpisodeId
		)


SELECT
@EpisodeName as Title,
@EpisodeId as 'Episode id',
@NumberCompanions as 'Number of companions',
@NumberEnemies as 'Number of enemies'