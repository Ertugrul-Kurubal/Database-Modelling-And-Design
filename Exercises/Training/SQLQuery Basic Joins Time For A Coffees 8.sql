-- Use inner joins to link lots of tables together, with a WHERE clause

SELECT aut.AuthorName, eps.Title, doc.DoctorName, enm.EnemyName,
	   LEN(aut.AuthorName) + LEN(eps.Title) + LEN(doc.DoctorName) + LEN(enm.EnemyName) AS 'Total length'
FROM tblAuthor AS aut INNER JOIN tblEpisode AS eps ON aut.AuthorId = eps.AuthorId
					  INNER JOIN tblDoctor AS doc ON doc.DoctorId = eps.DoctorId
					  INNER JOIN tblEpisodeEnemy AS eenm ON eenm.EpisodeId = eps.EpisodeId
					  INNER JOIN tblEnemy AS enm ON enm.EnemyId = eenm.EnemyId
WHERE (LEN(aut.AuthorName) + LEN(eps.Title) + LEN(doc.DoctorName) + LEN(enm.EnemyName)) < 40