
USE DoctorWho

SELECT
	
	-- report the companion's name
	c.CompanionName

FROM

	-- show ALL of the companions, and episode details where they exist
	tblCompanion AS c
	LEFT OUTER JOIN tblEpisodeCompanion AS ec 
		ON c.CompanionId = ec.CompanionId

WHERE

	-- don't show companions who have corresponding episodes
	ec.EpisodeCompanionId is null