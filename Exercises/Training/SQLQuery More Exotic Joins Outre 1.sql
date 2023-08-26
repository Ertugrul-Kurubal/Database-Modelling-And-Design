-- Write an SQL outer join to show unmatched records in another table

SELECT com.CompanionName 
FROM tblCompanion AS com 
LEFT OUTER JOIN tblEpisodeCompanion AS ecom
ON com.CompanionId = ecom.CompanionId
WHERE ecom.EpisodeId IS NULL