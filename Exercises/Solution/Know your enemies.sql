
-- choose a specific episode
DECLARE @EpisodeId int = 15

-- variable to hold the list of enemies
declare @EnemyList varchar(100) = ''

SELECT

	-- add in each enemy name
	@EnemyList = @EnemyList + 
		CASE WHEN len(@EnemyList) > 0 THEN ', ' ELSE '' END + 
		e.EnemyName
		
FROM

	tblEpisodeEnemy AS ec
	INNER JOIN tblEnemy AS e ON ec.EnemyId = e.EnemyId

WHERE
	ec.EpisodeId = @EpisodeId

-- show the results
SELECT 
	@EpisodeId as 'Episode id',
	@EnemyList AS 'Enemies'
	