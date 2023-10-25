-- Create a stored procedure with NULLs as the default values

/*CREATE PROC uspCategoryEvents (@CategoryName VARCHAR(100) = NULL, 
							   @After DATETIME = NULL, 
							   @CategoryID INT = NULL)
*/
ALTER PROC uspCategoryEvents (@CategoryName VARCHAR(100) = NULL, 
							   @After DATETIME = NULL, 
							   @CategoryID INT = NULL)
AS

SELECT c.CategoryName, e.EventDate, c.CategoryID
FROM
	tblEvent AS e INNER JOIN tblCategory AS c ON e.CategoryID = c.CategoryID
WHERE 
	(@CategoryName IS NULL OR c.CategoryName LIKE '%' + @CategoryName + '%') AND 
	(@After IS NULL OR e.EventDate >= @After) AND
	(@CategoryID IS NULL OR c.CategoryID = @CategoryID)
ORDER BY
	e.EventDate


EXEC uspCategoryEvents @CategoryName='death', @After='19900101'

EXEC uspCategoryEvents @CategoryId=16