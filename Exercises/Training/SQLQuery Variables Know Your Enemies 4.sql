-- Read a list of the enemies of Doctor Who into a string variable

USE DoctorWho
GO

DECLARE @EpisodeId int = 15

DECLARE @EnemyList varchar(100) = ''

SELECT @EnemyList = @EnemyList + 
					CASE WHEN LEN(@EnemyList) > 0 THEN ', ' ELSE '' END +
					en.EnemyName

FROM tblEpisodeEnemy AS ee
				INNER JOIN tblEnemy AS en
				ON ee.EnemyId = en.EnemyId
WHERE
	ee.EpisodeId = @EpisodeId


-- show the results

SELECT
@EpisodeId as 'Episode id',
@EnemyList AS 'Enemies'