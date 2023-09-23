USE Websites
GO

CREATE PROC spCalculateAge
AS

-- declare variable to hold your age
DECLARE @Age int

-- work out how old you are (DateDiff won't always 
-- give the correct answer, but that's OK for now)
SET @Age = DateDiff(year,'03/04/1964',GetDate())

-- print out your age
PRINT 'You are ' + CAST(@Age AS varchar(3)) + ' years old'
