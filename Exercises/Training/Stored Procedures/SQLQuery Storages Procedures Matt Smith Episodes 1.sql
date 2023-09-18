-- Create a stored procedure to list Dr Who episodes featuring Matt Smith

CREATE PROC spMattSmithEpisodes
AS
	SELECT  e.SeriesNumber AS 'Series', e.EpisodeNumber AS 'Episode',
	e.EpisodeDate AS 'Date of episode', d.DoctorName AS 'Doctor'	
	FROM tblEpisode AS e
		INNER JOIN tblDoctor AS d ON e.DoctorId = d.DoctorId
	WHERE d.DoctorName = 'Matt Smith'
	ORDER BY e.EpisodeDate ASC

ALTER PROC spMattSmithEpisodes
AS
	SELECT  e.SeriesNumber AS 'Series', e.EpisodeNumber AS 'Episode',
	e.EpisodeDate AS 'Date of episode', d.DoctorName AS 'Doctor'	
	FROM tblEpisode AS e
		INNER JOIN tblDoctor AS d ON e.DoctorId = d.DoctorId
	WHERE d.DoctorName = 'Matt Smith' AND YEAR(e.EpisodeDate) = 2012
	ORDER BY e.EpisodeDate ASC

EXEC spMattSmithEpisodes  -- Storage call for result