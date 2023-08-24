
SELECT
	Family.FamilyName,

	-- start with the top level, if there is one
	CASE	
		WHEN TopFamily.FamilyName is null THEN '' 
		ELSE TopFamily.FamilyName + ' > ' 
	END + 

	-- add on the next level, again if there is one
	CASE	
		WHEN ParentFamily.FamilyName is null THEN '' 
		ELSE ParentFamily.FamilyName + ' > '
	END + 

	-- there's always a bottom level
	Family.FamilyName AS 'Family path'
FROM

	-- start with the bottom level
	tblFamily AS Family

	-- use each family's parent to link to the next level up
	LEFT OUTER JOIN tblFamily AS ParentFamily
		ON Family.ParentFamilyId = ParentFamily.FamilyID

	-- repeat to get the "grandparent" family
	LEFT JOIN tblFamily AS TopFamily 
		ON ParentFamily.ParentFamilyId = TopFamily.FamilyID

ORDER BY
	Family.FamilyName