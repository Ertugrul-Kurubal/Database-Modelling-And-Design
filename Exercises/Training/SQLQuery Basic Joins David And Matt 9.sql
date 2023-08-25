-- Join two tables together in SQL, using alias table names

SELECT tblDoctor.DoctorName, tblEpisode.Title 
FROM tblDoctor INNER JOIN
     tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId
WHERE YEAR(tblEpisode.EpisodeDate) = 2010