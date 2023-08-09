

SELECT cba.Country, cba.KmSquared,
	 CAST((cba.KmSquared/20761) AS int) AS 'WalesUnits', (cba.KmSquared%20761) AS 'AreaLeftOver',
		CASE
			WHEN CAST((cba.KmSquared/20761) AS int) <1 THEN 'Smaller than Wales'
			WHEN CAST((cba.KmSquared/20761) AS int) >=1 THEN CAST((cba.KmSquared/20761) AS varchar) + ' x Wales plus ' + 
			CAST((cba.KmSquared%20761) AS varchar(100)) + ' sq. km'
		END AS 'WalesComparison'
FROM [CountriesByArea] AS cba
ORDER BY ABS(20761-cba.KmSquared) ASC 