

--Create a loop to cycle through each year of your life
DECLARE @StartYear INT = 1981 -- Start point of loop
DECLARE @EndYear INT = 2017 --End point either could be set equal to a select statement

WHILE @StartYear <= @EndYear -- The part that makes this a loop. Make sure you have an achievable end point. Or a counter which will end the loop if it seems to be impossible.

BEGIN --Clearly marks where the section to loop starts
DECLARE @CountEvents INT =(SELECT COUNT(*) FROM tblEvent WHERE YEAR(EventDate) = @StartYear) --Count how many events occurred in the current year

PRINT CAST(@CountEvents as varchar(4)) + ' events occurred in ' + cast(@StartYear as varchar(4))   -- Turn the count into text and concatenate it on
SET @StartYear += 1 --Increase the counter to approach the end point
	
END --Clearly marks where the section to loop ends