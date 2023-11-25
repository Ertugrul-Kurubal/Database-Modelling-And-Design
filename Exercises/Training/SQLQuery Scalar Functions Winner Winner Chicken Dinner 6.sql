-- Use a CASE statement to classify each event according to whether it is the top of its class or not

USE WorldEvents
GO

CREATE FUNCTION Winners (@Title VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @Rank VARCHAR(50) = ''
	SET @Rank =
		CASE 
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent ORDER BY EventDate) THEN 'Oldest'
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent ORDER BY EventDate DESC) THEN 'Newest'
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent ORDER BY EventName ) THEN 'First alphabetically'
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent ORDER BY EventName DESC ) THEN 'Last alphabetically'
				ELSE 'Not a winner'
		END
RETURN @RANK
END

------------------------------------------------------------

SELECT
	EventName, dbo.Winners(EventName) AS 'Winners'

FROM tblEvent

ORDER BY 'Winners'