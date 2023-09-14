USE [DoctorWho]
GO

ALTER PROC [dbo].[spRussell]
AS

-- show episodes written by Mr. Moffat
SELECT
	e.Title
	--a.AuthorName,
	--e.EpisodeDate
FROM	
	tblAuthor AS a
	INNER JOIN tblEpisode AS e ON a.AuthorId = e.AuthorId
WHERE
	a.AuthorName like 'Russell%'
ORDER BY
	e.EpisodeDate DESC