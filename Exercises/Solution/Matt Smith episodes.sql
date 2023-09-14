
CREATE PROC spMattSmithEpisodes
AS

SELECT

	ep.SeriesNumber AS Series,
	ep.EpisodeNumber AS Episode,
	ep.Title,
	ep.EpisodeDate AS 'Date of episode',
	d.DoctorName AS Doctor

FROM
	tblEpisode AS ep
	INNER JOIN tblDoctor AS d ON ep.DoctorId = d.DoctorId

WHERE
	d.DoctorName = 'Matt Smith'

ORDER BY
	ep.EpisodeDate