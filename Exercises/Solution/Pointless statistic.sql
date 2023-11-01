ALTER FUNCTION fnLetterCount(
	@first varchar(max),
	@second varchar(max)
)
RETURNS int
AS
BEGIN

	-- return the length of both columns
 	RETURN LEN(@first) + LEN(@second)

END
GO

-- test this out
SELECT dbo.fnLetterCount('Wise','Owl')
	AS 'Number of letters'

-- put in a query
SELECT
	e.EventName,
	e.EventDetails,
	e.EventDate,
	dbo.fnLetterCount(e.EventName,e.EventDetails) 
		AS 'Total letters'
FROM
	tblEvent AS e
ORDER BY
	'Total letters' ASC