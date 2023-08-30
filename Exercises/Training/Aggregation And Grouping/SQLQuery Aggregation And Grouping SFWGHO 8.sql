-- Use lots of grouping and criteria to list out year/doctor episode counts

SELECT YEAR(e.EpisodeDate) AS 'Episodes year', en.EnemyName, COUNT(*) AS 'Number of episodes'
FROM tblEpisode AS e
	INNER JOIN tblDoctor AS d ON e.DoctorId = d.DoctorId
	INNER JOIN tblEpisodeEnemy AS een ON een.EpisodeId = e.EpisodeId
	INNER JOIN tblEnemy AS en ON en.EnemyId = een.EnemyId	
WHERE YEAR(d.BirthDate) < 1970
GROUP BY YEAR(e.EpisodeDate), en.EnemyName
HAVING COUNT(*) > 1
ORDER BY 'Number of episodes' DESC