-- Create a view in the view designer, tidy up its SQL and use it to select data

/*
CREATE VIEW EventsByCategory AS

SELECT        TOP (100) PERCENT dbo.tblCategory.CategoryName AS Category, COUNT(dbo.tblEvent.EventName) AS What
FROM            dbo.tblCategory INNER JOIN
                         dbo.tblEvent ON dbo.tblCategory.CategoryID = dbo.tblEvent.CategoryID
GROUP BY dbo.tblCategory.CategoryName
ORDER BY COUNT(dbo.tblEvent.EventName) DESC

GO
*/

USE WorldEvents
GO

ALTER VIEW EventsByCategory AS
SELECT TOP 100 PERCENT
		c.CategoryName AS Category, COUNT(e.EventName) AS What
FROM tblCategory AS c
		INNER JOIN tblEvent AS e
		ON c.CategoryID = e.CategoryID
GROUP BY c.CategoryName
ORDER BY What ASC
GO  

SELECT * 
FROM EventsByCategory
WHERE What > 50

