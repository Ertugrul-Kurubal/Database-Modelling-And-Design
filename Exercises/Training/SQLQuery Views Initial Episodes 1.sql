-- Use the view designer to create a view, and change it in SQL

/*CREATE VIEW vwEpisodesByFirstLetter AS
SELECT a.AuthorName, d.DoctorName, e.Title, e.EpisodeDate       
FROM dbo.tblAuthor AS a INNER JOIN
     dbo.tblEpisode AS e ON a.AuthorId = e.AuthorId INNER JOIN
     dbo.tblDoctor AS d ON e.DoctorId = d.DoctorId
WHERE e.Title LIKE N'F%'
*/

USE DoctorWho
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW vwEpisodesByFirstLetter
AS

SELECT TOP (100) PERCENT 
	a.AuthorName, 
	d.DoctorName, 
	e.Title, 
	e.EpisodeDate
FROM     
	tblAuthor AS a 
	INNER JOIN tblEpisode AS e ON a.AuthorId = e.AuthorId 
	INNER JOIN tblDoctor as d ON e.DoctorId = d.DoctorId
WHERE e.Title LIKE N'h%'
ORDER BY e.EpisodeDate
GO

SELECT * FROM vwEpisodesByFirstLetter
GO