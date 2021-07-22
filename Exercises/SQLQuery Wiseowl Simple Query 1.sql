-- WORLDEVENTS DATABASE (WISEOWL)
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
/*SELECT TOP(3) CategoryID, CategoryName 
FROM [dbo].[tblCategory]
ORDER BY CategoryName DESC
*/

-- How times change
-- 4) Create a query which uses two separate SELECT statements to show the first and last 2 events in date
-- order from the tblEvent table:
/*SELECT TOP(2) EventName AS What, EventDate AS [When] 
FROM [dbo].[tblEvent]
ORDER BY EventDate ASC

SELECT TOP(2) EventName AS What, EventDate AS [When] 
FROM [dbo].[tblEvent]
ORDER BY EventDate DESC
*/