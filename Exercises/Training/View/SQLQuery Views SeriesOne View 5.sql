-- Script a view in a query, then use the view designer to edit it

USE DoctorWho
GO

/*
CREATE VIEW vwSeriesOne AS 
SELECT * 
FROM tblEpisode
WHERE SeriesNumber = 1
GO
*/

SELECT * FROM vwSeriesOne -- view is modified from right click Design and Series 1 is converted to Series 2