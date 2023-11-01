ALTER FUNCTION fnReign(
	@StartDate date,
	@EndDate date=null
)
RETURNS int
AS

BEGIN

	-- return difference in days between start and end date,
	-- using today's date as the end date if none is specified
	RETURN DateDiff(day,@StartDate,IsNull(@EndDate,GetDate()))

END

GO

SELECT
	DoctorName,

	-- show number of days between first and last episode (for 
	-- Peter  Capaldi, use today's date)
	dbo.fnReign(FirstEpisodeDate,LastEpisodeDate) AS 'Reign in days'

FROM
	tblDoctor
ORDER BY
	'Reign in days' DESC

