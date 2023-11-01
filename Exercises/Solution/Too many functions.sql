
ALTER FUNCTION fnNumberCompanions(
	@EpisodeId int
)
RETURNS int
AS
BEGIN

	-- count how many companions there are for a given episode
	RETURN (
		SELECT COUNT(*) FROM tblEpisodeCompanion
		WHERE EpisodeId = @EpisodeId
	)

END
GO

ALTER FUNCTION fnNumberEnemies(
	@EpisodeId int
)
RETURNS int
AS
BEGIN

	-- count how many enemies there are for a given episode
	RETURN (
		SELECT COUNT(*) FROM tblEpisodeEnemy
		WHERE EpisodeId = @EpisodeId
	)

END
GO

ALTER FUNCTION fnWords(
	@string varchar(max)
)
RETURNS int
AS
BEGIN

	-- count how many words there are in a given string of text
	-- (assumes no double spaces in words)
	DECLARE @s varchar(max) 
	
	-- first remove leading and closing spacing
	SET @s = LTRIM(RTRIM(@string))

	-- now find how many letters there are with and without spaces
	DECLARE @WithSpaces int
	DECLARE @withoutSpaces int

	SET @WithSpaces = len(@s)
	SET @WithoutSpaces = LEN(REPLACE(@s,' ',''))

	-- the number of spaces removed, plus one, is number of words (ish)
	RETURN @WithSpaces - @WithoutSpaces + 1

END
GO

-- show all these functions working
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