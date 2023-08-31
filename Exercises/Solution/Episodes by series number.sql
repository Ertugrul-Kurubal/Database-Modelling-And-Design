
USE DoctorWho
GO

-- script to create a new view
ALTER VIEW vwSeriesOne
AS

-- create a view to show series 1 episodes
SELECT

	e.Title,
	e.SeriesNumber,
	e.EpisodeNumber

FROM
	tblEpisode AS e
WHERE
	e.SeriesNumber = 2
GO

-- show all of the rows returned from the view
SELECT * FROM vwSeriesOne