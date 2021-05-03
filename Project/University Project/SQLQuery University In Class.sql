
use master

CREATE DATABASE University2;


USE University2;

---Tablolarda region isimlerinin yerine region id' lerini kullanarak 
--string yerine int ifadelerin çoklamasýný tercih ettik.



CREATE TABLE Region
(
RegionID INT IDENTITY(1, 1),
RegionName VARCHAR(25) CHECK (RegionName IN ('England', 'Scotland', 'Wales', 'Northern Ireland')) NOT NULL,
PRIMARY KEY (RegionID)
);




INSERT Region (RegionName)
VALUES('England'),
('Scotland'),
('Wales'),
('Northern Ireland');




CREATE TABLE Staff
(
StaffID INT IDENTITY(10, 1),
StaffName nVARCHAR(50) NOT NULL,
StaffSurname nVARCHAR(50) NOT NULL,
RegionID INT NOT NULL,
PRIMARY KEY (StaffID),
FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);



INSERT Staff (StaffName, StaffSurname,  RegionID)
VALUES('Selim', 'Aydin',  1),
('Semil', 'Acik', 1),
('Gungor', 'Salih', 1),
('Gulsum', 'Cicekci', 2),
('Hatice', 'Dogan', 2),
('Esra', 'Gamze', 3),
('Eda', 'Yucel', 4),
('Arslan', 'Celik', 3),
('Metin', 'Ozden', 4)




--Her öðrencinin sadece ve mutlaka bir staff' ý olabileceði için (null deðer olamayacaðý için)
--staff id 'nin student tablosunda olmasýnýn herhangi bir sakýncasý bulunmamaktadýr.
--Yani staff ile student arasýndaki danýþmanlýk iliþkisi student tablosunda saðlanmýþ oldu



CREATE TABLE Student
(
StudentID INT IDENTITY(20, 1),
StudentName nVARCHAR(50) NOT NULL,
StudentSurname nVARCHAR(50) NOT NULL,
StaffID INT NOT NULL,
RegionID INT NOT NULL,
RegistrationDate Date NOT NULL DEFAULT '2020-05-12',
PRIMARY KEY (StudentID),
FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);


INSERT INTO Student (StudentName, StudentSurname, StaffID, RegionID)
VALUES('Ali', 'Guzel', 10, 1),
('Osman', 'Yucel', 11, 1),
('Omer','Ilhan', 12, 1),
('Bekir', 'Gul', 13, 2),
('Ahmet', 'Cicek', 14, 2),
('Mehmet', 'Uyanik', 15, 3);



CREATE TABLE Course
(
CourseID INT IDENTITY(30, 1),
Title VARCHAR(50) NOT NULL,
Credit INT CHECK (Credit in (15,30)) NOT NULL,
Quota INT NULL,
PRIMARY KEY (CourseID)
);


INSERT Course (Title, Credit, Quota)
VALUES('Math', 30, 5),
('Physics', 30, 8),
('Chemistry', 30, 7),
('English', 30, null),
('Biology', 15, 10),
('Fine Arts', 15, null),
('German', 15, 17),
('Music', 30, 3),
('Psychology', 30 ,10);





CREATE TABLE Enrollment
(
StudentID INT  NOT NULL, 
CourseID INT NOT NULL, 
PRIMARY KEY (StudentID, CourseID),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);



---////////////////////////////


CREATE TABLE StaffCourse
(
StaffID INT NOT NULL,
CourseID INT NOT NULL, 
PRIMARY KEY (StaffID, CourseID),
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID), --ON DELETE CASCADE,
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);



INSERT INTO StaffCourse (StaffID, CourseID)
VALUES(10, 30),
(12, 30),
(10, 31),
(11, 31),
(12, 38)



--///////////////////////////

CREATE TABLE Assignment
(
StudentID INT REFERENCES Student(StudentID) NOT NULL, 
CourseID INT REFERENCES Course(CourseID) NOT NULL, 
AssignmentID INT NOT NULL,
Grade INT Check(Grade BETWEEN 0 AND 100) NOT NULL,
PRIMARY KEY (StudentID, CourseID, AssignmentID),
FOREIGN KEY (StudentID, CourseID) REFERENCES Enrollment(StudentID, CourseID)
);



--////////////////////


--constraints

--eðer bir öðrencinin credi kotasý 180 i aþarsa yeni insert iþleminin reddedilmesini istiyoruz
--fonksiyon credi kotasý aþýlýrsa 1, aþýlmamýþsa 0 döndürecek



Create FUNCTION dbo.check_credit()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int

	IF EXISTS (
				SELECT 1
				FROM	(
						SELECT	B.StudentID, sum(Credit) sum_credit
						FROM	Course A 
						INNER JOIN Enrollment B 
						ON		A.CourseID = B.CourseID
						GROUP BY B.StudentID
						) A
				WHERE sum_credit > 180
			) 
		SET @REJECT = 1 
	ELSE
		SET @REJECT = 0

RETURN @REJECT
END;



ALTER TABLE Enrollment
ADD CONSTRAINT CK_check_credit CHECK(dbo.check_credit() = 0);





INSERT INTO Enrollment (StudentID, CourseID)
VALUES (21, 30),
(21, 31),
(21, 32),
(21, 33),
(21, 37),
(21, 38)



--constraint' i test edelim. kabul etmiyor çalýþýyor

INSERT Enrollment VALUES (21, 35)


--Derslerin bazýlarýnýn öðrenci kotalarý mevcut. 
--Derse kaydolan Öðrenci sayýsýnýn, dersin kotasýndan fazla olmamasý için bir constraint tanýmlamamýz gerek
--Bunun için yine bir fonksiyon tanýmlýyoruz.



CREATE FUNCTION check_quota()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int
		IF EXISTS(
					SELECT 1
					FROM
					Course A
					INNER JOIN	(	
								SELECT CourseID, COUNT(DISTINCT StudentID) AS CNT_Student
								FROM Enrollment
								GROUP BY CourseID
								) B
					ON A.CourseID = B.CourseID
					WHERE A.Quota IS NOT NULL
					AND	  A.Quota < B.CNT_Student
				)
			SET @REJECT = 1 
		ELSE 
			SET @REJECT = 0

RETURN @REJECT
END;



ALTER TABLE Enrollment
ADD CONSTRAINT CK_check_quota CHECK(dbo.check_quota() = 0);


---constraint' i deneyelim 37 id numaralý course' un kotasý 3

select * from course


INSERT INTO Enrollment
VALUES 
(22, 37),
(23, 37)
,

(24, 37);--Yukarýda 37 id li kursa bir kayýt eklenmiþti, burada kota kýsýtý çalýþýyor ve 3. öðrenciye izin vermiyor.


--diðer kurslara uygulanmýþ mý bu kota?


--kotasý olmayan 35 id li kurs
INSERT Enrollment
VALUES (22, 35),
(23, 35),
(24, 35),
(25, 35);


--kotasý 17 olan 36 id li kurs
INSERT Enrollment
VALUES (22, 36),
(23, 36),
(24, 36),
(25, 36);


--sorun yok düzgün çalýþýyor

-------------------


--30 CREDÝLÝK BÝR DERS EN FAZLA 5 ASSIGNMENT' A SAHÝP OLABÝLÝR


CREATE FUNCTION check_num_of_assignment()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int
		IF EXISTS(
					SELECT 1
					FROM (
							SELECT count(DISTINCT A.AssignmentID) CNT_assignment
							FROM Assignment A 
							INNER JOIN Course B 
							ON A.CourseID = B.CourseID 
							WHERE B.Credit = 30 
							GROUP BY A.CourseID
						) A
					WHERE CNT_assignment > 5
				)
			SET @REJECT =1
		ELSE 
			SET @REJECT = 0

RETURN @REJECT;
END;


ALTER TABLE Assignment
ADD CONSTRAINT CN_check_num_of_assignment CHECK(dbo.check_num_of_assignment() = 0);



--constraint' i deneyelim


INSERT INTO Assignment (StudentID, CourseID, AssignmentID, Grade)
VALUES
(21, 30, 1, 90),
(21, 30, 2, 0),
(21, 30, 3, 85),
(21, 30, 4, 60),
(21, 30, 5, 100);


--6. ya izin vermedi çalýþýyor
INSERT INTO Assignment (StudentID, CourseID, AssignmentID, Grade)
VALUES	(21, 30, 6, 90)



--/////////////////////////


--15 credilik bir ders en fazla 3 assignment' a sahip olabilir


CREATE FUNCTION check_num_of_assignment2()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int
		IF EXISTS(
					SELECT 1
					FROM (
							SELECT count(DISTINCT A.AssignmentID) CNT_assignment
							FROM Assignment A 
							INNER JOIN Course B 
							ON A.CourseID = B.CourseID 
							WHERE B.Credit = 15 
							GROUP BY A.CourseID
						) A
					WHERE CNT_assignment > 3
				)
			SET @REJECT =1
		ELSE 
			SET @REJECT = 0

RETURN @REJECT;
END;



ALTER TABLE Assignment
ADD CONSTRAINT CK_check_num_of_assignment2 CHECK(dbo.check_num_of_assignment2() = 0);



--constraint' i kontrol edelim


INSERT INTO Assignment (StudentID, CourseID, AssignmentID, Grade)
VALUES
(25, 35, 1, 90),
(25, 35, 2, 50),
(25, 35, 3, 85)


--4. kayda izin vermedi, düzgün çalýþýyor

INSERT INTO Assignment (StudentID, CourseID, AssignmentID, Grade)
VALUES
(25, 35, 4, 100)



--////////////////////////////


--öðrencinin region' u ile öðretmenin region' u ayný olmalý


CREATE FUNCTION check_region()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int
		IF EXISTS(
					SELECT 1
					FROM StaffCourse A 
					INNER JOIN Enrollment B ON A.CourseID = B.CourseID
					INNER JOIN Student C ON B.StudentID = C.StudentID
					INNER JOIN Staff D ON D.StaffID = A.StaffID
					WHERE C.RegionID != D.RegionID
				)
			SET @REJECT = 1
		ELSE 
			SET @REJECT = 0

RETURN @REJECT
END;


ALTER TABLE Enrollment
ADD CONSTRAINT CK_check_region CHECK(dbo.check_region() = 0);



--CONSTRAINT' i deneyelim. kabul etmedi yani çalýþýyor


--25 id numaralý öðrencinin regionu ile 38 id' li dersi veren staff' in region'larý farklý olduðu için bu eþleþmeyi kabul etmemesi gerek

SELECT * FROM Student WHERE StudentID = 25


SELECT *
FROM StaffCourse A, Staff B
WHERE A.StaffID=B.StaffID
AND A.CourseID=38




INSERT INTO Enrollment
VALUES
(25, 38);






--------///////////////////


--öðrencinin region' u ile danýþmanýnýn region' u ayný olmalý

CREATE FUNCTION check_region2()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int
		IF EXISTS(
					SELECT 1
					FROM Student A INNER JOIN Staff B ON A.StaffID = B.StaffID 
					WHERE A.RegionID != B.RegionID
				)
			SET @REJECT =1
		ELSE 
			SET @REJECT = 0

RETURN @REJECT
END;


ALTER TABLE Student
ADD CONSTRAINT CK_check_region2 CHECK(dbo.check_region2() = 0);



--constraint'i kontrol edelim

--aþaðýdaki öðrenciler ile danýþmanlarýnýn regionid' leri uyuþtuðu için kabul ediyor
INSERT INTO Student (StudentName, StudentSurname, StaffID, RegionID)
VALUES
('Ayse', 'Menekse', 16, 4),
('Mehmet', 'Keles', 15, 3),
('Ahsen', 'Cure', 15, 3);




--fakat burada 16 nolu staff' in region' u 5 olmadýðý için bu insert' ý kabul etmiyor yani constraint çalýþýyor.
INSERT INTO Student (StudentName, StudentSurname, StaffID, RegionID)
VALUES
('Leyla', 'Tok', 16, 5)





--///////////////////////////////



------INSTRUCTIONS

--Instruction'lar son derste yapýlacak olan break out room uygulamasýnda sizlerden çözmeniz isteneceði için buraya konulmadý.
--Ders sonunda verilecek olan notebook' a çözümler eklenecektir.


-- Change a students grade by creating a SQL script that updates a students grade in the assignment table.
-- Update the credit for a course.
-- Swap the responsible staff of two students with each other in the student table.
-- Remove a staff member who is not assigned to any student from the staff table.
-- Add a student to the student table and enroll the student you added to any course.

SELECT * FROM [dbo].[Assignment]

UPDATE  [dbo].[Assignment] SET [Grade] = 50 WHERE Person_ID = 78962212466

UPDATE  [dbo].[Course] SET [Credit] = (SELECT [StudentID] FROM [dbo].[Assignment] where Person_ID = 78962212466) WHERE Person_ID = 78962212466

SELECT * FROM  WHERE StaffID NOT IN (SELECT StaffID FROM Staff)

SELECT * FROM Staff

SELECT * FROM StaffCourse

DECLARE @FIRSTSTAFF INT
DECLARE @SECONDSTAFF INT
SET @FIRSTSTAFF = (SELECT StaffID FROM Student WHERE StudentID = 23)
SET @SECONDSTAFF = (SELECT StaffID FROM Student WHERE StudentID = 24)

UPDATE Student
SET StaffID = @FIRSTSTAFF
WHERE StudentID = 24
UPDATE Student
SET StaffID = @SECONDSTAFF
WHERE StudentID = 23












