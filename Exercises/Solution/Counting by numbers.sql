USE DoctorWho

-- the episode number of interest
DECLARE @EpisodeId int = 42

-- get name of episode
DECLARE @EpisodeName varchar(50) = (
	SELECT Title
	FROM tblEpisode
	WHERE EpisodeId = @EpisodeId
)

-- count how many companions there are for this episode
DECLARE @NumberCompanions int = (
	SELECT COUNT(*)
	FROM tblEpisodeCompanion
	WHERE EpisodeId = @EpisodeId
)

-- count how many companions there are for this episode
DECLARE @NumberEnemies int = (
	SELECT COUNT(*)
	FROM tblEpisodeEnemy
	WHERE EpisodeId = @EpisodeId
)

-- list out the details for this episode
SELECT 
	@EpisodeName as Title,
	@EpisodeId as 'Episode id',
	@NumberCompanions as 'Number of companions',
	@NumberEnemies as 'Number of enemies'

--DECLARE @VariableName vartype = (
--	-- some select statement which returns a single value
--	SELECT ...
--)