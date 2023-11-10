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

CREATE FUNCTION fnWords(@string VARCHAR(MAX)
)
RETURNS INT
AS
BEGIN

	DECLARE @string2 VARCHAR(MAX) 

	SET @string2 = LTRIM(RTRIM(@string))

	DECLARE @WithSpaces INT
	DECLARE @withoutSpaces INT

	SET @WithSpaces = LEN(@string2)
	SET @WithoutSpaces = LEN(REPLACE(@string2,' ',''))

	RETURN @WithSpaces - @WithoutSpaces + 1

END
GO

---------------------------------------------------------------

SELECT
	EpisodeId, 
	Title,

	-- function to count number of companions for a given episode
	dbo.fnNumberCompanions(EpisodeId) AS Companions,

	-- function to count the number of enemies for an episode
	dbo.fnNumberEnemies(EpisodeId) AS Enemies,

	-- function to count the number of words (hint: use a combination
	-- of LTRIM and RTRIM to remove leading and trailing spaces, then
	-- REPLACE to change all spaces to empty strings and compare the 
	-- LEN of the string before and after this change!)
	dbo.fnWords(Title) AS Words

FROM 
	tblEpisode
ORDER BY 
	Words DESC