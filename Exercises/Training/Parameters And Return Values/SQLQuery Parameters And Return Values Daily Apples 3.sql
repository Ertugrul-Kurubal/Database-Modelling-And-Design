-- Create a procedure to list out the companions for a given doctor

/*CREATE PROC spCompanionsForDoctor (@DoctorName VARCHAR(50) = NULL)*/
ALTER PROC spCompanionsForDoctor (@DoctorName VARCHAR(50) = NULL) 
AS
SELECT DISTINCT co.CompanionName
FROM tblEpisode AS ep 
	INNER JOIN tblEpisodeCompanion AS epc ON ep.EpisodeId = epc.EpisodeId
	INNER JOIN tblCompanion AS co ON co.CompanionId = epc.CompanionId
	INNER JOIN tblDoctor AS doc ON doc.DoctorId = ep.DoctorId
WHERE doc.DoctorName LIKE '%' + @DoctorName + '%' OR @DoctorName IS NULL
ORDER BY
	co.CompanionName

GO
-- show 3 companions for Christpher Eccleston
spCompanionsForDoctor 'Ecc'

GO
-- show the 5 companions for Matt Smith
spCompanionsForDoctor 'matt'

GO
-- show the 17 companions for any doctor
spCompanionsForDoctor

GO