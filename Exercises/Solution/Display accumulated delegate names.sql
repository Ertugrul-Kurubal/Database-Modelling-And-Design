USE Training
GO

-- for a given course (here we assume course 1), show the delegates' names

-- variable to accumulate people's names
DECLARE @People varchar(MAX)
DECLARE @CourseName varchar(50)

SET @People = ''

-- get name of course
SET @CourseName = (
	SELECT
		c.CourseName
	FROM	
		tblSchedule AS s 
		INNER JOIN tblCourse AS c on s.CourseId=c.CourseId
	WHERE
		s.ScheduleId=1
)

-- now get list of people, separated by blank lines
SELECT
	@People =  @People + char(13) + char(10) + FirstName + ' ' + LastName
FROM	
	tblPerson AS p
	INNER JOIN tblDelegate AS d ON p.PersonId=d.DelegateId
	INNER JOIN tblSchedule AS s on d.ScheduleId=s.ScheduleId
	INNER JOIN tblCourse AS c on s.CourseId=c.CourseId
WHERE
	s.ScheduleId=1
ORDER BY
	FirstName ASC, LastName ASC

-- display accumulated names
PRINT ''
PRINT UPPER(@CourseName + ' delegates')
PRINT @People