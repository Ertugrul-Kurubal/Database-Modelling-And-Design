--Create the fucntion
CREATE FUNCTION Winners
(@Title varchar(max)) --Data type passed in
RETURNS VARCHAR(MAX) -- Data type passed out
as
BEGIN
DECLARE @Rank varchar(50) = ''
SET @Rank =
 CASE 
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent order by EventDate) THEN 'Oldest'
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent order by EventDate desc) THEN 'Newest'
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent order by EventName ) THEN 'First alphabetically'
				WHEN @Title in( SELECT top 1 EventName FROM tblEvent order by EventName desc ) THEN 'Last alphabetically'
				ELSE 'Not a winner'
			END --Test each event and return if it is a winner in any category or Not a winner


RETURN @RANK -- Store the results of the case in a variable and return the variable
END


-------------RUN IN A SEPERATE SCRIPT----------------------------
--Try the function on all the events
SELECT
	EventName
	,DBO.Winners(EventName) as 'Winners'

FROM
	tblEvent

order by
	'Winners'