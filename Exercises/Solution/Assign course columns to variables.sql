USE Training
GO

DECLARE @StartDate datetime			-- the date a course starts
DECLARE @CourseName varchar(50)		-- the name of each course
DECLARE @NumberDays int				-- the course length, in days

-- read in values for each variable for course number 17
SELECT
	@NumberDays = c.NumberDays,
	@CourseName=c.CourseName,
	@StartDate=s.StartDate
FROM
	tblSchedule AS s
	INNER JOIN tblCourse AS c ON s.CourseId=c.CourseId
WHERE
	s.ScheduleId=17

PRINT ''
PRINT 'About course number 17 ...'
PRINT '--------------------------'
PRINT ''

PRINT 'Start date: ' + CONVERT(char(10),@StartDate,103) 
PRINT 'Course name: ' + upper(@CourseName)
PRINT 'Course length: ' + CAST(@NumberDays AS varchar(2)) + ' day(s)'

