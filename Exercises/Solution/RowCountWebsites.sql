USE Websites
GO

CREATE PROC spNumberSitesAffected
AS

-- variable to hold number of sites listed
DECLARE @NumberSites int

-- don't show number of rows affected
-- (makes MESSAGES window look neater)
SET NOCOUNT ON

-- list out the number of websites
SELECT * FROM tblWebsite

-- remember how many there were
SET @NumberSites = @@rowcount

-- print summary 
PRINT 'Summary of query'
PRINT '----------------'
PRINT 'This listed ' + CAST(@NumberSites AS varchar(5)) + ' sites'