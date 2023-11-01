--Create a function that takes the numbers 1-12 and returns the monthname

CREATE FUNCTION MonthName --The lay out for a function is very close to a stored proc, oddly MonthName goes pink but has no function.
(@MonthNumber INT)
RETURNS VARCHAR(10) --Functions almost always return a different data type. Therefore you have to tell SQL what the data type is thats being passed out is...even if it's the same!
AS

BEGIN
RETURN --Since there is only one possible value to bring back RETURN can go at the top
	DATENAME(MM,'2017-' + CAST(@MonthNumber as varchar(2)) + '-01') --The month and day are irrelevant since we are joining just to cut out the monthname


END


-------------RUN IN A SEPERATE SCRIPT -----------------------------
--Testing out all the months can be done quickly with a loop
DECLARE @COUNTER INT = 1 
WHILE @Counter <= 12
begin
PRINT
	dbo.MonthName(@COUNTER) -- All user generated functions need to have the schema infront of them. For most users that will be the default dbo or data base owner

Set @counter +=1
END