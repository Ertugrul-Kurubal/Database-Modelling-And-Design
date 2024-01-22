-- Create a transaction, add Shaun the Sheep as a Doctor Who, then commit or roll this back

USE DoctorWho
GO

-- add a new Doctor Who
BEGIN TRANSACTION

-- this should go within a transaction
INSERT INTO tblDoctor (
	DoctorName,
	DoctorNumber
)
	VALUES (
	'Shaun the Sheep',
	13
)

-- roll back or commit
IF 2+2=5 
	ROLLBACK --yap�lan t�m i�lemler transaction'�n ba�lang�c�ndaki haline geri d�ner.
ELSE
	COMMIT

SELECT 
	DoctorId,
	DoctorNumber,
	DoctorName
FROM 
	tblDoctor

-- delete the extra doctor
DELETE FROM tblDoctor
WHERE DoctorNumber = 13