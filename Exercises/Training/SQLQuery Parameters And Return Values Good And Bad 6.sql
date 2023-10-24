-- Count rows and pass the information out of a procedure using output parameters

CREATE PROC spGoodAndBad (@SeriesNumber INT, @NumEnemies INT OUTPUT, @NumCompanions INT OUTPUT)
AS

SELECT @NumEnemies = COUNT(DISTINCT(ee.EpisodeId)),
	   @NumCompanions = COUNT(DISTINCT(ec.CompanionId))
FROM
	tblEpisode AS e INNER JOIN tblEpisodeEnemy AS ee ON e.EpisodeId = ee.EpisodeId
	INNER JOIN tblEpisodeCompanion AS ec ON e.EpisodeId = ec.EpisodeId
WHERE e.SeriesNumber = @SeriesNumber OR @SeriesNumber IS NULL



GO

DECLARE @SeriesNumber INT = 3
DECLARE @NumEnemies INT
DECLARE @NumCompanions INT

EXEC spGoodAndBad 
	@SeriesNumber, 
	@NumEnemies OUTPUT, 
	@NumCompanions OUTPUT

-- show the results
SELECT 
	@SeriesNumber AS 'Series number',
	@NumEnemies AS 'Number of enemies',
	@NumCompanions AS 'Number of companions'
