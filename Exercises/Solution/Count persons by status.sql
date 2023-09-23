USE TRAINING
GO

-- query to show number of people who have left and are still there

DECLARE @NumberCurrent int		-- number of people who still work
DECLARE @NumberLeft int			-- number of people whose status is 2 (left)

-- find out how many people still work at their companies
SET @NumberCurrent = (
	SELECT 
		COUNT(*) 
	FROM 
		tblPerson AS p
		INNER JOIN tblPersonStatus AS s 
			ON p.PersonStatusId=s.PersonStatusId
	WHERE
		PersonStatusName = 'Current'
)

-- find out how many people have left	
SET @NumberLeft = (
	SELECT 
		COUNT(*) 
	FROM 
		tblPerson AS p
		INNER JOIN tblPersonStatus AS s 
			ON p.PersonStatusId=s.PersonStatusId
	WHERE
		PersonStatusName = 'Obsolete'
)

-- print the results
PRINT 
	'Left: ' + CAST(@NumberLeft AS varchar(10)) +
	', ' +
	'Current: ' + CAST(@NumberCurrent AS varchar(10))
