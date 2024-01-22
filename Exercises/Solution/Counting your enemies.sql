
-- start transaction for setting number of enemies
BEGIN TRANSACTION

DECLARE @NumberUpdates int

-- set the number of enemies for each episode
UPDATE 	
	tblEpisode
SET
	NumberEnemies = (
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
		SELECT CAST(@NumberUpdates AS varchar(10)) +
			' rows updated, but change rolled back'
	END
ELSE

	BEGIN
		-- otherwise, accept change and show results
		COMMIT
		SELECT 
			EpisodeId,
			Title,
			NumberEnemies
		FROM
			tblEpisode
	END

	






