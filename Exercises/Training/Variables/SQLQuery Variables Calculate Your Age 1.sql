-- Create a simple stored procedure with a single variable to work out your age, and then print it out

/*CREATE DATABASE Websites*/

USE Websites
GO

CREATE PROC spCalculateAge
AS

DECLARE @Age int

SET @Age = DateDiff(year,'01/05/1991',GetDate())

PRINT 'You are ' + CAST(@Age AS varchar(3)) + ' years old'

EXEC spCalculateAge