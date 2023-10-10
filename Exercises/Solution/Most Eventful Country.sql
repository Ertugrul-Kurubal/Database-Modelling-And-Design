

alter PROC uspMostNumerous
(@TopCountry varchar(250) =NULL OUTPUT --Putting a default value means SQL won't ask for a value to be passed in
, @EventCount int  = NULL OUTPUT) -- OUTPUT tells SQL you will be passing a value out
AS

SELECT TOP 1 --Parameters like variables can only hold one row
	@TopCountry = CountryName --Values go into parameters just like variables
	,@EventCount= COUNT(E.CountryID) 
FROM
	tblEvent AS E INNER JOIN
	tblCountry AS C ON E.CountryID = C.CountryID
GROUP BY
	CountryName
ORDER BY
	COUNT(E.CountryID) desc -- Largest count first



------------RUN IN A SEPERATE SCRIPT-----------------------

DECLARE @CountryVariable varchar(250) --To hold the output parameters
DECLARE @EventCountVariable int

EXEC uspMostNumerous
@TopCountry = @CountryVariable OUTPUT --It looks like you would be passing the value from the variable into the parameter. Normally this is the case.
,@EventCount = @EventCountVariable OUTPUT --However using OUTPUT changes the direction of data pass. So this is passing a value from parameter to the variable.

Select
	@CountryVariable as 'Country of interest', @EventCountVariable --Select both variables to prove you have captured the valyes in the output parameters

