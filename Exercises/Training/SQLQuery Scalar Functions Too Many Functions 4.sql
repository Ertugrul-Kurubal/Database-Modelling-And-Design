-- Create all sorts of scalar functions in SQL to return info about Dr Who episodes from within a query
USE DoctorWho
GO

CREATE FUNCTION fnNumberCompanions(@EpisodeId INT)
RETURNS INT
AS 
BEGIN

	RETURN (SELECT COUNT(*)
			FROM tblEpisodeCompanion
			WHERE EpisodeId = @EpisodeId
			)
END
GO

CREATE FUNCTION fnNumberEnemies(@EpisodeId INT)
RETURNS INT
AS 
BEGIN

	RETURN (SELECT COUNT(*)
			FROM tblEpisodeEnemy
			WHERE EpisodeId = @EpisodeId
			)
END
GO