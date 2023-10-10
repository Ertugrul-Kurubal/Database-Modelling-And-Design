
ALTER PROC spListEpisodes(
	@SeriesNumber int = null
)
AS

-- list out all of the episodes for a given series of Dr Who
SELECT
	Title,
	SeriesNumber,
	EpisodeNumber
FROM
	tblEpisode
WHERE
	-- if no parameter specified, series number will be null
	-- and we'll get every single episode
	SeriesNumber = @SeriesNumber or @SeriesNumber IS null
GO

-- show all of the episodes
spListEpisodes
