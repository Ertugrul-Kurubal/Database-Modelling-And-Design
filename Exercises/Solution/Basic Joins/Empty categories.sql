

/*
	THE FIRST VERSION - INNER JOIN (OMITS EMPTY CATEGORIES)
*/
SELECT

	-- from events table
	e.EventName,
	e.EventDate,

	-- from the category table
	c.CategoryName

FROM
	tblCategory AS c

	-- join categories and events tables
	INNER JOIN tblEvent AS e
		on C.CategoryID = e.CategoryID

ORDER BY
	e.EventDate DESC

	
/*
	THE SECOND VERSION - OUTER JOIN (SHOWS EMPTY CATEGORIES)
*/
SELECT

	c.CategoryName

FROM
	tblCategory AS c

	-- join categories and events tables
	LEFT OUTER JOIN tblEvent AS e
		on C.CategoryID = e.CategoryID

WHERE

	-- show categories with no events
	e.EventID is null

ORDER BY 
	e.EventDate DESC