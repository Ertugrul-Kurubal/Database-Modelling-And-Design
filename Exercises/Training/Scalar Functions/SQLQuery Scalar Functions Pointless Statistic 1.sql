-- Count the number of letters for an event using a scalar function

/*
CREATE FUNCTION LetterCount(
					@firstvar VARCHAR(MAX),
					@secondvar VARCHAR(MAX))
*/

ALTER FUNCTION LetterCount(
					@firstvar VARCHAR(MAX),
					@secondvar VARCHAR(MAX))
	RETURNS INT
	AS
	BEGIN
		RETURN LEN(@firstvar) + LEN(@secondvar)
	END
GO

-------------------------------------------------------------------

-- this should return the number 7 (4 + 3)

SELECT dbo.LetterCount('Wise','Owl')

AS 'Number of letters'

-------------------------------------------------------------------

SELECT
	e.EventName,
	e.EventDetails,
	e.EventDate,
	dbo.LetterCount(e.EventName,e.EventDetails) 
		AS 'Total letters'
FROM
	tblEvent AS e
ORDER BY
	'Total letters' ASC