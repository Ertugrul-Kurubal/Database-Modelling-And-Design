use worldevents

BEGIN TRAN DoesEventExist --Be careful this is case sensitive

IF (SELECT count(*) FROM tblEvent WHERE EventName LIKE 'My DOB' ) <> 0 --Count how many events have My DOB, if it's not zero undo the transaction
	BEGIN
		ROLLBACK TRAN DoesEventExist
		SELECT 'This magnificent event already exists' AS EventResults --If it exists we give a message telling us this and rollback the tran
		
	END
ELSE --If it doesnt exist the ELSE will be triggered
	BEGIN		
		INSERT INTO tblEvent (EventName,EventDetails,EventDate) --Add the new event
		VALUES ('My DOB', 'I was born and the world trembles', '1991-04-26')
		COMMIT TRAN DoesEventExist
		SELECT 'This momentous event has now been added' AS EventResults --Commit the changes and tell the world
	END
	
SELECT top 1 * FROM tblEvent order by eventid desc --Either way select the pre-existing or newly created event



--DELETE FROM tblEvent WHERE EventName LIKE 'My DOB'


	