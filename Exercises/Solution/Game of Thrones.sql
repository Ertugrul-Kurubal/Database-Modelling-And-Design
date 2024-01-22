--set identity_insert dbo.tblcontinent on 
DECLARE @Continent VARCHAR(100) = 'Westeros' -- Add a new continent 
--INSERT INTO tblContinent (ContinentID,ContinentName)
--Values (9,@Continent)
--SELECT * FROM tblContinent ORDER BY ContinentID desc

BEGIN TRAN GameOfThrones --Begin a transaction
DELETE tblContinent WHERE ContinentName = @Continent -- Delete Westeros

IF LEFT(@Continent,1) = 'S' --Undo the delete if the letter of your first name isn't the same as the first letter of Westeros
BEGIN
	SELECT 'You have died' AS 'Lost the game' --Send a cheeky message
	ROLLBACK TRAN GameOfThrones --Undo the delete of Westeros
	UPDATE tblContinent SET ContinentName = 'Seven Kingdoms' WHERE ContinentName = 'Westeros' --Change Westeros to Seven Kingdoms
	SELECT * FROM tblContinent order by ContinentID desc
END
ELSE --If you do have W as your first letter you win! Otherwise on the second time around you will win.
BEGIN
	SELECT 'You have won' AS 'Won the game of thrones' --Wooo much better than dying
	COMMIT TRAN GameOfThrones --Save the delete action
	SELECT * FROM tblContinent order by ContinentID desc
END