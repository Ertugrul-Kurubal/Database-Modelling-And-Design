USE DoctorWho
GO

ALTER PROC spGoodAndBad(
	@SeriesNumber int,
	@NumberEnemies int output,
	@NumberCompanions int output
) 
AS

-- work out how many enemies there are, and how many companions
DECLARE @enemies int = (
	SELECT COUNT(DISTINCT EnemyId)
	FROM 
		tblEpisodeEnemy AS ee
		INNER JOIN tblEpisode AS e ON ee.EpisodeId = e.EpisodeId
	WHERE
		e.SeriesNumber = @SeriesNumber
)
DECLARE @companions int = (
	SELECT COUNT(DISTINCT CompanionId)
	FROM 
		tblEpisodeCompanion AS ec
		INNER JOIN tblEpisode AS e ON ec.EpisodeId = e.EpisodeId
	WHERE
		e.SeriesNumber = @SeriesNumber
)

-- return both numbers
SET @NumberEnemies = @enemies
SET @NumberCompanions =  @companions

GO

DECLARE @SeriesNumber int = 3
DECLARE @NumEnemies int
DECLARE @NumCompanions int

EXEC spGoodAndBad 
	@SeriesNumber, 
	@NumEnemies output, 
	@NumCompanions output

-- show the results
SELECT 
	@SeriesNumber AS 'Series number',
	@NumEnemies AS 'Number of enemies',
	@NumCompanions AS 'Number of companions'



	

