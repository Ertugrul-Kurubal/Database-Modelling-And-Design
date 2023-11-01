ALTER FUNCTION fnEpisodeDescription(
	@title varchar(100)
)
RETURNS varchar(50)
AS

BEGIN

	DECLARE @PartDescription varchar(50)

	-- look for words "part 1", "part 2" respectively
	-- (note how indentation makes code easier to read)
	SET @PartDescription =
		CASE		
			WHEN CHARINDEX('part 1', @title) > 0 
				THEN 'First part'
			WHEN CHARINDEX('part 2', @title) > 0 
				THEN 'Second part'
			ELSE
				'Single episode'
		END

	RETURN @PartDescription
END
GO

-- show episodes with descriptions
SELECT 
	EpisodeId,
	Title,
	dbo.fnEpisodeDescription(Title) AS Description
FROM
	tblEpisode

-- count number of episodes of each type
SELECT
	dbo.fnEpisodeDescription(Title) AS 'Episode type',
	COUNT(*) AS 'Number of episodes'
FROM
	tblEpisode
GROUP BY
	dbo.fnEpisodeDescription(Title)
