--To do this exercise, you'll need to know that you can use the LEN function to work out how many 
-- characters there are in a bit of text.

-- Use this nugget of information to create a query listing out each event with the length of its name, 
-- with the "shortest event" first:

SELECT EventName, LEN(EventName) AS 'Length of name' FROM tblEvent ORDER BY 'Length of name' ASC