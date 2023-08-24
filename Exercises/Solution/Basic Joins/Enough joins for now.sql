
USE DoctorWho

SELECT

	-- show the episode title, enemy and author
	ep.Title, 
	en.EnemyName,
	a.AuthorName

FROM

	-- start with authors, and work our way across
	tblAuthor AS a
	INNER JOIN tblEpisode AS ep ON a.AuthorId = ep.AuthorId
	INNER JOIN tblEpisodeEnemy AS ee ON ep.EpisodeId = ee.EpisodeId
	INNER JOIN tblEnemy AS en ON ee.EnemyId = en.EnemyId

WHERE
	en.EnemyName like '%Dalek%'