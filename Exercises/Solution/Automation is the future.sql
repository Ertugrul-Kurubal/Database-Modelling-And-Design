


DECLARE @Month INT = 1 -- Choose the starting month....probably January
DECLARE @December INT = 12 --Choose ending month......hopefully December

WHILE @Month <= @December --Loop until the month number is December
BEGIN
DECLARE @EventList VARCHAR(MAX) = '' --Create the list variable

SELECT @EventList += EventName + ', ' FROM tblEvent WHERE MONTH(EventDate) = @Month --Select all the events which occurred in the current month

PRINT 'Events which occurred in ' + DATENAME(MM, '2017-' + CAST(@Month AS VARCHAR(2)) + '-01') + ': ' + @EventList   --Print your list with the month infront
--The year and day are irrelevant since we are rebuilding a datetime to just split out the month name

SET @Month += 1	--Increase the month number
END