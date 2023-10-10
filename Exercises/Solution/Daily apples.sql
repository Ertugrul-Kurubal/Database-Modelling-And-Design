
ALTER PROC spCompanionsForDoctor(
	@DoctorName varchar(50) = null
)
AS

-- show all of the companions who have accompanied this doctor
SELECT DISTINCT
	c.CompanionName
FROM
	tblDoctor AS d
	INNER JOIN tblEpisode AS e on d.DoctorId = e.DoctorId
	INNER JOIN tblEpisodeCompanion AS ec on e.EpisodeId = ec.EpisodeId
	INNER JOIN tblCompanion AS c ON ec.CompanionId = c.CompanionId
WHERE
	-- either the doctor matches the name chosen, or show all companions
	-- if the doctor name parameter isn't specified
	d.DoctorName like '%' + @DoctorName + '%' or
	@DoctorName is null
ORDER BY
	c.CompanionName
GO

-- show 3 companions for Christpher Eccleston
spCompanionsForDoctor 'Ecc'
GO

-- show 5 companions for Matt Smith
spCompanionsForDoctor 'matt'
GO

-- show 17 companions for any doctor
spCompanionsForDoctor 
GO




