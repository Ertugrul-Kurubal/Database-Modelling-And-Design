

CREATE DATABASE University;

USE University;


CREATE TABLE Register 
(
StudentID bigint,
[Name] varchar(50),
Surname varchar(50),
RegisterDate date,
[Date] datetime,
[Location] nvarchar(50)
PRIMARY KEY (StudentID)
);



CREATE TABLE Staff 
(
StaffID bigint,
[Name] varchar(50),
Surname varchar(50),
[Location] nvarchar(50),
Job varchar(50)
PRIMARY KEY (StaffID)
);



CREATE FUNCTION dbo.homework
(
	@NUM INT
)
RETURNS INT
AS
BEGIN
	DECLARE @OUT INT
	DECLARE @COURSECREDIT INT
	SET @COURSECREDIT = (SELECT Credit FROM Course WHERE Credit = @NUM)
	IF @COURSECREDIT > 15
		SET @OUT = 5
	ELSE
		SET @OUT = 3
RETURN @OUT
END;

CREATE TABLE Course 
(
CourseID bigint PRIMARY KEY,
[Name] varchar(20),
Credit int,
Homework int,
Quota int,
CONSTRAINT homework_condition CHECK(Homework <= [dbo].[homework](Credit))
);

------------------------------------------------------
/*CREATE FUNCTION dbo.score
(
	@NUM2 bigint
)
RETURNS INT
AS
BEGIN
	DECLARE @OUT2 INT
	SET @OUT2 = SELECT Homework FROM Course WHERE CourseID = (SELECT CourseID FROM CourseScore WHERE StudentID = @NUM2)
RETURN @OUT2
END;
*/

CREATE TABLE CourseScore   ----Adding Constraint for Score
(
CourseID bigint,
StudentID bigint,
Score int,
FOREIGN KEY (CourseID) REFERENCES Course (CourseID),
FOREIGN KEY (StudentID) REFERENCES Register (StudentID)
);

CREATE FUNCTION dbo.loc
(
	@LOC bigint
)
RETURNS bit
AS
BEGIN
	DECLARE @STLOC bigint
	DECLARE @STFLOC bigint
	DECLARE @STAT bit
	SET @STLOC = (SELECT [Location] FROM Register WHERE StudentID = @LOC)
	SET @STFLOC = (SELECT [Location] FROM Staff WHERE StaffID = (SELECT StaffID FROM Conselor WHERE StudentID = @LOC))
	IF @STLOC = @STFLOC
		SET @STAT = 'TRUE'
	ELSE
		SET @STAT = 'FALSE'
RETURN @STAT
END;


CREATE TABLE Conselor 
(
StudentID bigint,
StaffID bigint ,
Region int,
CONSTRAINT loc_condition CHECK(dbo.loc(StudentID)='TRUE'),
FOREIGN KEY (StudentID) REFERENCES Register (StudentID),
FOREIGN KEY (StaffID) REFERENCES Staff (StaffID)
);

CREATE TABLE CourseLecturer 
(
StaffID bigint,
CourseID bigint
FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

-----------------------------------------------------------------------------------------

INSERT Register(StudentID,[Name], Surname, RegisterDate,[Date], [Location]) 
VALUES (201910010,'Arthur','Rose', 2019, 05/09/2019, 'England'),
	   (201910017,'Beth', 'Mac', 2019,	05/09/2019,	'Scotland'),
	   (201910024,'David',	'Kahnmar', 2019, 07/09/2019,'Northern Ireland'),
	   (201910043,	'Rosa',	'Johnson', 2019, 08/09/2019, 'Scotland')
		