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
