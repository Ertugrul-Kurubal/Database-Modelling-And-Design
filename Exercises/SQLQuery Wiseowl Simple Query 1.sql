-- What a way to start
-- 1)
/*SELECT EventName, EventDate  FROM [dbo].[tblEvent]
Order by EventDate DESC
*/

-- The dawn of histor
-- 2)
/*SELECT TOP(5) EventName AS What, EventDetails AS Details  
FROM [dbo].[tblEvent]
ORDER BY EventDate
*/

-- Last 3 categories
-- 3)
SELECT TOP(3) CategoryID, CategoryName 
FROM [dbo].[tblCategory]
ORDER BY CategoryName DESC