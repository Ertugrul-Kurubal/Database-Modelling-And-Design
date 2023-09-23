

DECLARE @Name varchar(20) = 'Sam Lowrie' --Declare creates the variable 
DECLARE @DOB DATETIME = '1981-04-26' --All variable names must start with @
DECLARE @Pets INT = 8 --The datatype is to tell sql what will be stored

SELECT 'My name is ' + @Name + ', I was born on ' + convert(varchar(50),@DOB,103) + ' and I have ' + cast(@Pets as varchar(50))+ ' pets' AS 'Fun facts'
--Need to cast or convert the non-character variables into text to allow concatenation


--DECLARE @Variable1 DataType = 'Your Name'
--SET @Variable2 = 'Your dob'
--SELECT @Variable3 = 'Your number of pets'