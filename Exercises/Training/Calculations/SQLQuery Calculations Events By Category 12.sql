-- Create a query to list out for each event the category number that it belongs to:

SELECT EventName + 
		' (category' +  CAST(CategoryID AS varchar(100)) + ')'
		AS 'Event (category)'
FROM tblEvent WHERE CountryID = 1