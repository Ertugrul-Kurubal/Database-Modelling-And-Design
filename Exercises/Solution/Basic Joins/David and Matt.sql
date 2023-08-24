
-- show doctors and their episodes
SELECT

	doc.DoctorName,
	e.Title

FROM
	tblDoctor AS doc 

	-- link to the episodes table
	INNER JOIN tblEpisode AS e
		ON doc.DoctorId = e.DoctorId

WHERE
	year(e.EpisodeDate) = 2010