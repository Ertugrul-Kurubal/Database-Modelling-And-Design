-- Create a stored procedure to list Dr Who episodes for a series number, using a default parameter value

CREATE PROC spListEpisodes(@SeriesNumber INT = NULL)
AS

SELECT e.Title, e.SeriesNumber, e.EpisodeNumber 
FROM tblEpisode AS e
WHERE e.SeriesNumber = @SeriesNumber OR @SeriesNumber IS NULL

GO
-- spListEpisodes 2
spListEpisodes