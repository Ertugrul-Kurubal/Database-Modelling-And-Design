-- Use the CHARINDEX function multiple times to show the number of characters between two words in a text string

SELECT e.EventName, e.EventDate,
		CHARINDEX('this', e.EventDetails, 1) AS 'thisPosition',
		CHARINDEX('that', e.EventDetails, 1) AS 'thatPosition',
		CHARINDEX('that',e.EventDetails,1) - CHARINDEX('this',e.EventDetails,1) AS Offset

FROM tblEvent AS e
WHERE CHARINDEX('this', e.EventDetails, 1) > 1 AND
CHARINDEX('that', e.EventDetails, 1) > 1 AND
(
(CHARINDEX('that',e.EventDetails,1) - CHARINDEX('this',e.EventDetails,1)) > 1
)

