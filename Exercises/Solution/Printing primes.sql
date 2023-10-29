USE Training
GO

DECLARE @current int					-- the current number whose primeness we're testing
DECLARE @previous int					-- the number we're trying to divide into this

DECLARE @HighestFactor decimal(10,4)	-- the highest possible factor of the number we're testing
DECLARE @HighestFactorInteger int		-- the same thing, rounded down to the nearest integer
DECLARE @IfPrime bit					-- whether the number we're testing is prime (1) or not (0)

-- see how long it takes!
DECLARE @StartTime datetime
DECLARE @EndTime datetime

SET @StartTime = CURRENT_TIMESTAMP

-- start with 2, and work our way up!
SET @current=2
WHILE @current < 50
	BEGIN

		-- assume that the number is prime to start with
		SET @IfPrime=1

		-- work out what the highest possible factor could be (eg square root of 10 is 3.162, so
		-- the highest possible factor is 3)
		SET @HighestFactor = sqrt(@current)
		SET @HighestFactorInteger = floor(@HighestFactor)

		-- start with 2, and work our way up
		SET @previous = 2
		WHILE @previous <= @HighestFactorInteger
			BEGIN	
				IF @current % @previous = 0 
					BEGIN
						
						-- if dividing by this number leaves no remainder, then it wasn't a prime 
						-- (and there's no point testing if any other numbers this one)
						SET @IfPrime=0
						BREAK
					END

				-- try the next factor
				SET @previous = @previous + 1
				
			END
			
			-- if this was prime, print it out
			IF @IfPrime=1 PRINT CAST(@current AS varchar(10))

		-- try the next possible prime
		SET @current = @current + 1

	END

SET @EndTime = CURRENT_TIMESTAMP 
PRINT 'Took ' + CAST(DateDiff(ms, @StartTime, @EndTime) AS varchar(10)) + ' milliseconds'