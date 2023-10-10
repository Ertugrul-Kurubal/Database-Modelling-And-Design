--Stored procedure orders the continents by number of events. Then stores the name of the continent with the most in an OUTPUT parameter.
CREATE PROC uspContinentToUse
(@FirstContinent varchar(100) = NULL output) --Ouput parameters need the word OUTPUT
as
SELECT TOP 1
	@FirstContinent =  ContinentName --Storing the name of the continent with the most events

FROM
	tblEvent AS E INNER JOIN 
	tblCountry AS C ON E.CountryID = C.CountryID INNER JOIN
	tblContinent AS CC ON CC.ContinentID = C.ContinentID
ORDER BY
	EventDate ASC

------------------RUN IN A SEPERATE SCRIPT ---------------------------------
--Stored procedure that shows all the events for a given continent
CREATE PROC uspEventsInContinent 
(@ContinentName varchar(100))
as
SELECT
	EventName
	,EventDate
	,ContinentName
FROM
	tblEvent AS E INNER JOIN 
	tblCountry AS C ON E.CountryID = C.CountryID INNER JOIN
	tblContinent AS CC ON CC.ContinentID = C.ContinentID
WHERE
	ContinentName = @ContinentName

------------------RUN IN A SEPERATE SCRIPT ---------------------------------

--The aim is to pass the value from one stored procedure to another. Cutting out the middle man and automating the process.
DECLARE @VariableFirstContinet VARCHAR(100) = ''

EXEC uspContinentToUse
@FirstContinent = @VariableFirstContinet OUTPUT --Pass the value from the first stored procedure into a variable within this script.

select @VariableFirstContinet --Show the value inside the variable

EXEC uspEventsInContinent --Pass the value from the variable into the parameter of the next procedure
@ContinentName = @VariableFirstContinet

--You should now see all the events which occured in your given continent.