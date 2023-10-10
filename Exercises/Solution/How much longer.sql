
create PROC uspHowMuchLonger
AS
DECLARE @Difference INT

SELECT
	@Difference = mAX(LEN(EVENTNAME)) - MIN(LEN(EVENTNAME)) --Len returns the number of characters in a string of text. Max returns the longest and Min the shortest

FROM
	tblEvent

RETURN @Difference -- Brings back one INT, no more and no less.




-------------RUN IN A SEPERATE SCRIPT-----------------------------

DECLARE @VariableName INT --The variable will hold the returned value
EXEC  @VariableName = uspHowMuchLonger --To put a value into a variable set it = to the stored procedure

SELECT 'The difference between the longest event name and the shortest is: ' + CAST(@VariableName AS VARCHAR(5)) + ' characters' AS 'How much longer?'