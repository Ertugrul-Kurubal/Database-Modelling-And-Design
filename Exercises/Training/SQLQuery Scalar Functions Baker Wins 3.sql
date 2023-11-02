-- Use a scalar function to include each Dr Who's incarnation dates in a query

ALTER FUNCTION fnReign(
					@startdate DATE,
					@enddate DATE = NULL)
RETURNS INT
AS

BEGIN
	RETURN DATEDIFF(day, @startdate, IsNull(@enddate, GetDate()))
END
GO

-----------------------------------------------------------------

SELECT
	DoctorName,
	dbo.fnReign(FirstEpisodeDate,LastEpisodeDate) AS 'Reign in days'
FROM
	tblDoctor
ORDER BY
	'Reign in days' DESC