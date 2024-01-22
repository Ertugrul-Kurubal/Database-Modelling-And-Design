-- Create a transaction to update all countries that aren't your own, then roll it back

USE WorldEvents
GO

UPDATE tblCountry SET CountryName += ' (My Country)' WHERE CountryName  LIKE '%United kingdom%' --Add 'My country' to which ever country you call home

BEGIN TRAN T1

UPDATE tblCountry SET CountryName += ' (Holiday Destination)' WHERE CountryName NOT LIKE '%United kingdom%' --Start by adding Holiday to all countries but your 

IF 1+ 1 = 2 --Check if this impossible question is true
	BEGIN
		ROLLBACK TRAN T1 --If by some weird glitch it's true undo the update
		SELECT * FROM tblCountry order by CountryName	-- Prove the update didn't happen	
	END
ELSE --If it is false however save the changes and show that it has changed
	BEGIN
		SELECT * FROM tblCountry order by CountryName
		COMMIT TRAN T1		
	END

---------------------------------------------------------------

-- reset country names
UPDATE tblCountry

SET CountryName = REPLACE(CountryName,

' (Holiday Destination)','')

-- check this worked

SELECT * FROM tblCountry

-----------------------

UPDATE tblCountry

SET CountryName = REPLACE(CountryName,

' (My Country)','')

-- check this worked

SELECT * FROM tblCountry

