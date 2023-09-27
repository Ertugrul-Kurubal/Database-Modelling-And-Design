-- Given the name of a Doctor Who, use variables to print details for him

DECLARE @DoctorNumber INT = 9

DECLARE @DoctorId INT
DECLARE @DoctorName VARCHAR(100)

SELECT
	@DoctorId = DoctorId,
	@DoctorName = DoctorName
FROM
	tblDoctor 
WHERE
	DoctorNumber = @DoctorNumber

DECLARE @NumberEpisodes INT = (
	SELECT COUNT(*) FROM tblEpisode
	WHERE DoctorId = @DoctorId
)

PRINT ''
PRINT 'Results for doctor number ' + CAST(@DoctorId AS varchar(100))
PRINT '----------------------------'
PRINT ''
PRINT 'Doctor name: ' + upper(@DoctorName)
PRINT ''
PRINT 'Episodes appeared in: ' + CAST(@NumberEpisodes AS varchar(10))