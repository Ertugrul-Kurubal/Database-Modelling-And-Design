
-- show the details for a given doctor
DECLARE @DoctorNumber int = 9

-- get the id number and name of this doctor
DECLARE @DoctorId int
DECLARE @DoctorName varchar(100) 

-- set the name of this doctor
SELECT
	@DoctorId = DoctorId,
	@DoctorName = DoctorName
FROM
	tblDoctor 
WHERE
	DoctorNumber = @DoctorNumber

-- get number of episodes
DECLARE @NumberEpisodes int = (
	SELECT COUNT(*) FROM tblEpisode
	WHERE DoctorId = @DoctorId
)

-- show progress to date
PRINT ''
PRINT 'Results for doctor number ' + CAST(@DoctorId AS varchar(100))
PRINT '----------------------------'
PRINT ''
PRINT 'Doctor name: ' + upper(@DoctorName)
PRINT ''
PRINT 'Episodes appeared in: ' + CAST(@NumberEpisodes AS varchar(10))


