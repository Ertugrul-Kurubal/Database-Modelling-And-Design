-- Use return values to bring back an INT return value from a stored procedure
ALTER PROC uspHowMuchLonger
AS
DECLARE @Difference INT

SELECT @Difference = MAX(LEN(e.EventName)) - MIN(LEN(e.EventName))
FROM tblEvent AS e
RETURN @Difference


DECLARE @VariableName INT
EXEC  @VariableName = uspHowMuchLonger
SELECT 'The difference between the longest event name and the shortest is: '
		+ CAST(@VariableName AS VARCHAR(5)) + ' characters' AS 'How much longer?'