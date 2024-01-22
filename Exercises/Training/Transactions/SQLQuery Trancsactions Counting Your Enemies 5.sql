-- Update the number of Dr Who enemies within a transaction, and commit or roll this back

USE DoctorWho
GO

-- start transaction for setting number of enemies
BEGIN TRANSACTION

DECLARE @NumberUpdates INT

-- set the number of enemies for each episode
UPDATE 	
	tblEpisode
SET
	@NumberUpdates = (
		SELECT 
			COUNT(*) 
		FROM 
			tblEpisodeEnemy AS ee
		WHERE 
			ee.EpisodeId = e.EpisodeId
	)
FROM
	tblEpisode AS e

-- find out how many rows were changed
SET @NumberUpdates = @@ROWCOUNT

-- if this was more than n, undo change
IF @NumberUpdates > 120 
	BEGIN
		ROLLBACK
		SELECT CAST(@NumberUpdates AS VARCHAR(10)) +
			' rows updated, but change rolled back'
	END
ELSE

	BEGIN
		-- otherwise, accept change and show results
		COMMIT
		SELECT 
			EpisodeId,
			Title,
			@NumberUpdates
		FROM
			tblEpisode
	END