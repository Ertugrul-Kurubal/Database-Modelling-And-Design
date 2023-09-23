--Declare the variables you will need
DECLARE @EarliestDate DATETIME
DECLARE @LatestDate DATETIME
DECLARE @NumberOfEvents INT
DECLARE @EventInfo	VARCHAR(100)

--Select the aggregated values into variables
SELECT
	@EarliestDate= MIN(EventDate)
	,@LatestDate = MAX(EventDate)
	,@NumberOfEvents = COUNT(*)
	,@EventInfo = 'Summary of events'
FROM
	 tblEvent AS E 
-- Select the variables to see the aggregated values returned
SELECT
	@EventInfo AS [Title]
	,CONVERT(VARCHAR(10),@EarliestDate,103) AS [Earlest Date]
	,CONVERT(VARCHAR(10),@LatestDate,103)  AS [Latest Date]
	,@NumberOfEvents AS [Number of Events]
