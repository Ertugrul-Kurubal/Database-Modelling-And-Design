-- Create 2 self-joins between a table of families and itself, to show families, their parents and their grandparents

SELECT Family.FamilyName,

	CASE	
		WHEN TopFamily.FamilyName IS NULL THEN '' 
		ELSE TopFamily.FamilyName + ' > ' 
	END + 

	CASE	
		WHEN ParentFamily.FamilyName IS NULL THEN '' 
		ELSE ParentFamily.FamilyName + ' > '
	END + 
	Family.FamilyName AS 'Family path'

-- other way    
--	(ISNULL(TopFamily.FamilyName + ' -> ', '') +  ISNULL(ParentFamily.FamilyName + ' -> ' , '') + Family.FamilyName)
--    AS 'Family Path'

FROM tblFamily AS Family
	LEFT OUTER JOIN tblFamily AS ParentFamily ON Family.ParentFamilyId = ParentFamily.FamilyID
	LEFT OUTER JOIN tblFamily AS TopFamily ON ParentFamily.ParentFamilyId = TopFamily.FamilyID
ORDER BY Family.FamilyName