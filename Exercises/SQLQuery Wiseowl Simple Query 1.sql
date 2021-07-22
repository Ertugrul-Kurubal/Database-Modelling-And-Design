-- WORLDEVENTS DATABASE (WISEOWL)
-- What a way to start
-- 1) Create a query to list out the following columns from the tblEvent table, with the most recent first (for which you'll need to use an 
-- ORDER BY clause):
/*SELECT EventName, EventDate  FROM [dbo].[tblEvent]
Order by EventDate DESC
*/

-- The dawn of histor
-- 2) Write a query to show the first 5 events (in date order) from the tblEvent table:
/*SELECT TOP(5) EventName AS What, EventDetails AS Details  
FROM [dbo].[tblEvent]
ORDER BY EventDate
*/

-- Last 3 categories
-- 3) Create a query to list out the id number and name of the last 3 categories from the tblCategory table in 
-- alphabetical order:
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