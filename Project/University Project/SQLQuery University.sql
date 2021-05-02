

CREATE DATABASE University;

USE University;


CREATE TABLE Register 
(
StudentID bigint,
[Name] varchar(50),
Surname varchar(50),
RegisterDate int,
[Date] date,
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
	SET @COURSECREDIT = (SELECT Credit FROM Course WHERE CourseID = @NUM)
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
CONSTRAINT homework_condition CHECK(Homework <= [dbo].[homework](CourseID))
);

------------------------------------------------------
/*SELECT 100*SUM(C.Homework) FROM Register A 
INNER JOIN CourseScore B ON A.StudentID = B.StudentID 
INNER JOIN Course C ON B.CourseID = C.CourseID
WHERE A.StudentID  = 201910010 */
------------------------------------------------------

CREATE FUNCTION dbo.score 
(
	@NUM2 bigint
)
RETURNS INT
AS
BEGIN
	DECLARE @OUT2 INT
	SET @OUT2 = (SELECT 100*SUM(C.Homework) FROM Register A INNER JOIN CourseScore B ON A.StudentID = B.StudentID INNER JOIN Course C ON B.CourseID = C.CourseID WHERE A.StudentID  = @NUM2)
RETURN @OUT2
END;

CREATE FUNCTION dbo.credits
(
	@NUM3 bigint
)
RETURNS bigint
AS
BEGIN
	DECLARE @OUT3 INT
	DECLARE @STAT2 bigint
	SET @OUT3 = (SELECT SUM(C.Credit) FROM Register A INNER JOIN CourseScore B ON A.StudentID = B.StudentID INNER JOIN Course C ON B.CourseID = C.CourseID WHERE A.StudentID  = @NUM3)
	IF @OUT3 <= 180
		SET @STAT2 = @NUM3
	ELSE
		SET @STAT2 = 0
RETURN @STAT2
END;

-------------------------------
/*SELECT COUNT(A.CourseID) FROM Course A 
INNER JOIN CourseScore B ON A.CourseID = B.CourseID 
INNER JOIN Register C ON B.StudentID = C.StudentID 
WHERE A.CourseID  = 141*/

CREATE FUNCTION dbo.quota
(
	@NUM4 bigint
)
RETURNS bigint
AS
BEGIN
	DECLARE @OUT4 INT
	DECLARE @STAT4 bigint
	SET @OUT4 = (SELECT COUNT(A.CourseID) FROM Course A INNER JOIN CourseScore B ON A.CourseID = B.CourseID INNER JOIN Register C ON B.StudentID = C.StudentID WHERE A.CourseID  = @NUM4)
	IF @OUT4 <= (SELECT Quota FROM Course WHERE CourseID = @NUM4)
		SET @STAT4 = @NUM4
	ELSE
		SET @STAT4 = 0
RETURN @STAT4
END;

CREATE TABLE CourseScore 
(
CourseID bigint,
StudentID bigint,
Score int,
CONSTRAINT quota_condition CHECK(CourseID = [dbo].[quota](CourseID)),
CONSTRAINT score_condition CHECK(Score <= [dbo].[score](StudentID)),
CONSTRAINT credit_condition CHECK(StudentID = [dbo].[credits](StudentID)),
FOREIGN KEY (CourseID) REFERENCES Course (CourseID),
FOREIGN KEY (StudentID) REFERENCES Register (StudentID)
);

CREATE FUNCTION [dbo].[locations]
(
	@LOC bigint
)
RETURNS bigint
AS
BEGIN
	DECLARE @STLOC bigint
	DECLARE @STFLOC bigint
	DECLARE @STAT bigint
	SET @STLOC = (SELECT [Location] FROM Register WHERE StudentID = @LOC)
	SET @STFLOC = (SELECT [Location] FROM Staff WHERE StaffID = (SELECT StaffID FROM Conselor WHERE StudentID = @LOC))
	IF @STLOC = @STFLOC
		SET @STAT = @LOC
	ELSE
		SET @STAT = 0
RETURN @STAT
END;

CREATE TABLE Conselor 
(
StudentID bigint,
StaffID bigint ,
Region int,
CONSTRAINT loc_condition CHECK(StudentID = [dbo].[locations](StudentID)),
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

SELECT FORMAT (getdate(), 'dd-MM-yy') as date
GO


INSERT Register(StudentID,[Name], Surname, RegisterDate,[Date], [Location]) 
VALUES (201910010,'Arthur','Rose', 2019, '2019-09-05', 'England'),
	   (201910017,'Beth', 'Mac', 2019,	'2019-09-05',	'Scotland'),
	   (201910024,'David',	'Kahnmar', 2019, '2019-09-07','Northern Ireland'),
	   (201910043, 'Rosa',	'Johnson', 2019, '2019-09-08', 'Scotland'),
	   (201910045, 'Mike',	'Brown', 2019, '2019-09-08', 'Wales'),
	   (202010001, 'Rachel','Moon', 2020, '2020-09-12', 'England'),
	   (202010007, 'Evan','Flowers', 2020, '2020-09-15', 'England'),
	   (202010011, 'Nicholas', 'McKenny', 2020,	'2020-09-15',	'Scotland'),
	   (202010023, 'Ava', 'Lopez',2020,	'2020-09-16', 'Northern Ireland'),
	   (202110015, 'Rita', 'Max', 2021,	'2021-09-15',	'Northern Ireland')
	   ;

INSERT Staff(StaffID, [Name], Surname, [Location], Job)
VALUES (10025012,	'Kevin',	'Ramsey',	'Wales',	'Insructor'),
		(10025013,	'Jack',	'Smith',	'Wales',	'Instructor'),
		(20035005,	'Andrew',	'Flasher',	'England',	'Instructor'),
		(20035010,	'Maria',	'Maria',	'England',	'Instructor'),
		(30045005,	'Adam',	'Londan',	'Scotland',	'Instructor'),
		(30045013,	'Jack',	'Mathal',	'Scotland',	'Instructor'),
		(30045019,	'Matthew',	'Ferguson',	'Scotland',	'Instructor'),
		(40055011,	'Alice',	'Karter',	'Northern Ireland',	'Instructor'),
		(40055020,	'Aida',	'Brook',	'Northern Ireland',	'Instructor')
		;

INSERT Course(CourseID, [Name], Credit, Homework, Quota)
VALUES (140,	'C++',	30,	4,	40),
		(101,	'Ethics',	15,	2,	40),
		(170,	'Math',	30,	2,	40),
		(175,	'Physics',	30,	2,	40),
		(211,	'Electronic-I',	30,	3,	30),
		(212,	'Electronic-II',	30,	4,	30),
		(270,	'Low Voltage',	15,	2,	30),
		(301,	'Electric Motor-I',	30,	3,	30),
		(302,	'Electric Motor-II',	30,	3,	30),
		(340,	'Digital Analysis',	15,	1,	30),
		(352,	'Automatic Control',	30,	3,	30),
		(401,	'Digital Filter',	15,	2,	20),
		(406,	'Analog Filter',	15,	2,	20),
		(475,	'High Voltage',	30,	3,	20),
		(452,	'Power Electronics',	30,	5,	20)
		;

INSERT CourseLecturer(CourseID,StaffID)
VALUES (140, 10025012),
		(101, 10025012),
		(170, 10025013),
		(175, 20035005),
		(211, 20035010),
		(212, 20035010),
		(270, 30045005),
		(301, 30045013),
		(302, 30045013),
		(340, 10025012),
		(352, 30045019),
		(401, 10025012),
		(406, 10025012),
		(475, 40055011),
		(452, 40055020)
		;

INSERT 
