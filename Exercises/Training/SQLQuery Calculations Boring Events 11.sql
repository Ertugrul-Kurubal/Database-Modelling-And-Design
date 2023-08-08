-- Divide events according to whether their first/last letters are the same or vowels

SELECT t.EventName,
	CASE 
		
		WHEN CHARINDEX(left(t.EventName,1),'aeiou',1) > 0 and
		left(t.EventName,1) = right(t.EventName,1) THEN 'Same vowel'

		WHEN left(t.EventName,1) = right(t.EventName,1) THEN 'Same letter'
	    
		WHEN CHARINDEX(left(t.EventName,1),'aeiou',1) > 0 and CHARINDEX(right(t.EventName,1),'aeiou',1) > 0 THEN
			'Begins and ends with vowel'
		
		ELSE 'Boring event!'
	
	END AS 'Verdict'

FROM tblEvent AS t 

WHERE

	CASE
		WHEN left(t.EventName,1) = right(t.EventName,1) THEN 'Same letter'
		WHEN CHARINDEX(left(t.EventName,1),'aeiou',1) > 0 and CHARINDEX(right(t.EventName,1),'aeiou',1) > 0 THEN
			'Begins and ends with vowel'
		ELSE 'Boring event!'
	END <> 'Boring event!'
--	END = 'Boring event!'  for boring event  
		
ORDER BY
	t.EventDate ASC