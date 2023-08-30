-- Group by 2 fields and use HAVING clause to show popular combinations

SELECT a.AuthorName, d.DoctorName, COUNT(*) AS 'Episodes'
FROM tblEpisode AS e
	INNER JOIN tblAuthor AS a ON e.AuthorId = a.AuthorId
	INNER JOIN tblDoctor AS d ON e.DoctorId = d.DoctorId
GROUP BY a.AuthorName, d.DoctorName
HAVING COUNT(*) > 5
ORDER BY 'Episodes' DESC