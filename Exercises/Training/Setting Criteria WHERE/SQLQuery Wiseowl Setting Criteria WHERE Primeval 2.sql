
-- 1) SELECT * FROM [dbo].[tblEvent] WHERE CategoryID <> 14 AND EventDetails LIKE '%Train%'

-- 2)SELECT * FROM [dbo].[tblEvent] WHERE CountryID = 13 AND (EventName NOT LIKE '%Space%'
-- AND EventDetails NOT LIKE '%Space%')

-- 3) SELECT * FROM [dbo].[tblEvent] WHERE (CategoryID = 5 OR CategoryID = 6) AND 
-- EventDetails NOT LIKE '%War%' AND EventDetails NOT LIKE '%Death%'
--   Other Solutions
-- SELECT * FROM [dbo].[tblEvent] WHERE CategoryID IN (5,6) AND 
-- EventDetails NOT LIKE '%War%' AND EventDetails NOT LIKE '%Death%'
