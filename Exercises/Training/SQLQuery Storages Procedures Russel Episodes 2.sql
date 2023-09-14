-- Create a stored procedure to list Dr Who episodes written by Steven Moffat

CREATE PROC spMoffats
AS
SELECT        tblEpisode.Title, tblAuthor.AuthorName, tblEpisode.EpisodeDate
FROM            tblAuthor INNER JOIN
                         tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
WHERE        (tblAuthor.AuthorName = N'Steven Moffat')
ORDER BY tblEpisode.EpisodeDate DESC

EXEC sp_rename 'spMoffats', 'spRussell' -- rename storage 

ALTER PROC spRussell
AS
SELECT        tblEpisode.Title, tblAuthor.AuthorName, tblEpisode.EpisodeDate
FROM            tblAuthor INNER JOIN
                         tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
WHERE        (tblAuthor.AuthorName LIKE N'Russel%')
ORDER BY tblEpisode.EpisodeDate DESC

EXEC spRussell