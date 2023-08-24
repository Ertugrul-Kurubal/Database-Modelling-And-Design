
USE DoctorWho

SELECT

	a.AuthorName, 
	e.Title,
	d.DoctorName,
	en.EnemyName,

	-- total length of the four columns being shown
	Len(a.AuthorName) + len(e.Title) + 
	len(d.DoctorName) + len(en.EnemyName) AS 'Total length'

FROM

	-- lots of joining!
	tblAuthor AS a
	INNER JOIN tblEpisode as e on a.AuthorId = e.AuthorId
	INNER JOIN tblDoctor as d on e.DoctorId = d.DoctorId
	INNER JOIN tblEpisodeEnemy as ee on e.EpisodeId = ee.EpisodeId
	INNER JOIN tblEnemy as en on ee.EnemyId = en.EnemyId

WHERE
	Len(a.AuthorName) + len(e.Title) + len(d.DoctorName) + len(en.EnemyName) < 40

ORDER BY 
	e.SeriesNumber,
	e.EpisodeNumber