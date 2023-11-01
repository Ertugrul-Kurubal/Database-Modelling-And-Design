-- Use an SQL function within a query to find out the part number of any Dr Who episode

/*As a guide, CHARINDEX('owl','Wise Owl') would return 6, 
whereas CHARINDEX('fox','Wise Owl') would return 0.*/

/*
CREATE FUNCTION fnEpisodeDescription(
						@title VARCHAR(MAX))
*/
ALTER FUNCTION fnEpisodeDescription(
						@title VARCHAR(MAX))
	RETURNS VARCHAR(MAX)
	AS
	 BEGIN
			DECLARE @PartDescription varchar(50)
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

---------------------------------------------------------------------

SELECT 
	EpisodeId,
	Title,
	dbo.fnEpisodeDescription(Title) AS Description
FROM
	tblEpisode

---------------------------------------------------------------------

SELECT
	dbo.fnEpisodeDescription(Title) AS 'Episode type',
	COUNT(*) AS 'Number of episodes'
FROM
	tblEpisode
GROUP BY
	dbo.fnEpisodeDescription(Title)