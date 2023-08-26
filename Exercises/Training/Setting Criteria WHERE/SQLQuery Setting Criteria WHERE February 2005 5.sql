-- Create a query which lists out all of the events which took place in February 2005:

-- SELECT t.EventName AS 'What', t.EventDate AS 'When' FROM tblEvent AS t 
-- WHERE t.EventDate LIKE '2005-02-__'

-- SELECT t.EventName AS 'What', t.EventDate AS 'When' FROM tblEvent AS t 
-- WHERE YEAR(t.EventDate) = 2005 AND MONTH(t.EventDate) = 2 

-- select * from tblEvent
-- where EventDate between '2005-02-01' and '2005-02-28'