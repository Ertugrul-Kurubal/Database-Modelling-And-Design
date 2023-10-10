
ALTER PROC uspCategoryEvents
(@CategoryName varchar(100)  = NULL --Null is the only value found in all data types
,@After DATETIME = NULL -- If no value is passed in each parameter will hold a null
,@CategoryID INT = NULL)
AS

SELECT
	C.CategoryName
	,e.EventDate
	,c.CategoryID
FROM
	tblEvent AS E INNER JOIN
	tblCategory AS C ON C.CategoryID = E.CategoryID
WHERE
	(@CategoryName IS NULL OR CategoryName LIKE '%' + @CategoryName + '%') AND --IS NULL is a true/false if there is a NULL then no filtering occurs
	(@After IS NULL OR EventDate >= @After) AND --If there isn't a NULL then the value in the parameter will be used for filtering
	(@CategoryID IS NULL OR c.CategoryID = @CategoryID)
ORDER BY
	EventDate