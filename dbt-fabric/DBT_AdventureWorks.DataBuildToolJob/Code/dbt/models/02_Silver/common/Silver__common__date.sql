{{config(
    materialization='table'
)}}

WITH cross_join_table as (
SELECT 1 as ID
UNION ALL
SELECT 1 as ID
UNION ALL
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID
UNION ALL 
SELECT 1 as ID),
Number_Table as (
--will give a potential of 100k rows
SELECT ROW_NUMBER() OVER (ORDER BY t.ID) as Number, 
DATEADD(DD, ROW_NUMBER() OVER (ORDER BY t.ID), '2000-01-01') as [Date] --As begin date
FROM cross_join_table as t
CROSS JOIN cross_join_table as a
CROSS JOIN cross_join_table as b
CROSS JOIN cross_join_table as c
CROSS JOIN cross_join_table as d
),

Date_Table as (
SELECT 
	[Date], 
	[Number], 
	ROW_NUMBER() OVER (ORDER BY Number DESC ) as [NumberReverse], 
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) DESC ) as [YearSequenceReversed],
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) ASC, DATEPART(qq, [Date]) ASC ) as [QuarterSequence],
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) DESC, DATEPART(qq, [Date]) DESC  ) as [QuarterSequenceReversed],
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) ASC, MONTH([Date]) ASC ) as [MonthSequence],
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) DESC, MONTH([Date]) DESC  ) as [MonthSequenceReversed],
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) ASC, DATEPART(week, [Date]) ASC ) as [WeekSequence],
	DENSE_RANK() OVER (ORDER BY YEAR([Date]) DESC, DATEPART(week, [Date]) DESC  ) as [WeekSequenceReversed],
    DATEADD(MM, 6, [Date]) as FiscalDate --Fiscal
FROM Number_Table
WHERE [Date] <= '2049-12-31' --As end date
), 
Calendar_and_Fiscal_Dates as(
SELECT 
	[Date], 
	[Number], 
	[NumberReverse], 
	[YearSequenceReversed],
	[QuarterSequence],
	[QuarterSequenceReversed],
	[MonthSequence],
	[MonthSequenceReversed],
	[WeekSequence],
	[WeekSequenceReversed],
    [FiscalDate],
	DENSE_RANK() OVER (ORDER BY YEAR([FiscalDate]) DESC ) as [FiscalYearSequenceReversed],
	DENSE_RANK() OVER (ORDER BY YEAR([FiscalDate]) ASC, DATEPART(qq, [FiscalDate]) ASC ) as [FiscalQuarterSequence],
	DENSE_RANK() OVER (ORDER BY YEAR([FiscalDate]) DESC, DATEPART(qq, [FiscalDate]) DESC  ) as [FiscalQuarterSequenceReversed],
	DENSE_RANK() OVER (ORDER BY YEAR([FiscalDate]) ASC, DATEPART(week, [FiscalDate]) ASC ) as [FiscalWeekSequence],
	DENSE_RANK() OVER (ORDER BY YEAR([FiscalDate]) DESC, DATEPART(week, [FiscalDate]) DESC  ) as [FiscalWeekSequenceReversed]
FROM Date_Table
)

SELECT 
    CONVERT(INT, CONVERT(VARCHAR(4), DATEPART(yyyy, [Date])) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(mm, [Date])), 2) + 
    RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(dd, [Date])), 2)) as [DateKey],
    CONVERT(DATETIME2(6), [Date]) as [Date],
    [Number] as [DateSequence],
    [NumberReverse] as [DateSequenceReversed] ,
    DATEPART(weekday, [Date]) as [WeekDayNumber] ,
    case DATEPART(weekday, [Date])
                when 1 then 'Sunday'
                when 2 then 'Monday'
                when 3 then 'Tuesday'
                when 4 then 'Wednesday'
                when 5 then 'Thursday'
                when 6 then 'Friday'
                else 'Saturday' 
    end as [WeekDayName] ,
    case DATEPART(weekday, [Date])
                when 1 then 'Sun'
                when 2 then 'Mon'
                when 3 then 'Tue'
                when 4 then 'Wed'
                when 5 then 'Thu'
                when 6 then 'Fri'
                else 'Sat' 
    end as [WeekDayName3] ,
    DATEPART(day, [Date]) as [DayOfMonthNumber],
    DATEPART(dayofyear, [Date]) as [DayOfYearNumber] ,
    [WeekSequence],
    [WeekSequenceReversed],
    'W' + CONVERT(VARCHAR(2),DATEPART(week, [Date])) + ' ' + CONVERT(VARCHAR(4), DATEPART(yyyy,[Date])) as [Week],
    DATEPART(week, [Date]) as [WeekNumber],
    'W' + CONVERT(VARCHAR(2),DATEPART(week, [Date])) as [WeekName] ,
    
    [MonthSequence],
    [MonthSequenceReversed],
    CONVERT( VARCHAR(10), LEFT(DATENAME(month, [Date]), 3) + ' ' + CONVERT(VARCHAR(4), DATEPART(yyyy,[Date]))) as  [Month],
    DATEPART(mm, [Date]) as [MonthNumber] ,
    CONVERT( VARCHAR(12),DATENAME(month, [Date])) as [MonthName] ,
    CONVERT( VARCHAR(3), LEFT(DATENAME(month, [Date]), 3)) as  [MonthName3] ,
    [QuarterSequence],
    [QuarterSequenceReversed],    
    'Q' + CONVERT(VARCHAR(2),DATEPART(qq, [Date])) + ' ' + CONVERT(VARCHAR(4), DATEPART(yyyy,[Date])) as [Quarter] ,
    
    DATEPART(qq, [Date]) as [QuarterNumber] ,
    'Q' + CONVERT(VARCHAR(2),DATEPART(qq, [Date])) as [QuarterName] ,
    [YearSequenceReversed],
	DATEPART(yyyy, [Date]) as [Year],


	DATEPART(dayofyear, [FiscalDate]) as [FiscalDayOfYearNumber] ,
	[FiscalWeekSequence],
	[FiscalWeekSequenceReversed],
	'W' + CONVERT(VARCHAR(2),DATEPART(week, [FiscalDate])) + ' ' + CONVERT(VARCHAR(4), DATEPART(yyyy,[FiscalDate])) as [FiscalWeekOfYear],
	DATEPART(week, [FiscalDate]) as [FiscalWeekOfYearNumber],
    'W' + CONVERT(VARCHAR(2),DATEPART(week, [FiscalDate])) as [FiscalWeekName] ,
	--Using Calendar Month with Fiscal Year on purpose
	CONVERT(VARCHAR(10), LEFT(DATENAME(month, [Date]), 3) + ' ' + CONVERT(VARCHAR(4), DATEPART(yyyy,[FiscalDate]))) as  [FiscalMonth],
	--purposely leaving out Fiscal Month Number and Fiscal Month Name as its just plain confusing unless someone requests it
	--DATEPART(mm, [FiscalDate]) as [FiscalMonthNumber] ,
    --DATENAME(month, [FiscalDate]) as [FiscalMonthName] ,
	[FiscalQuarterSequence],
	[FiscalQuarterSequenceReversed],
	'Q' + CONVERT(VARCHAR(2),DATEPART(qq, [FiscalDate])) + ' ' + CONVERT(VARCHAR(4), DATEPART(yyyy,[FiscalDate])) as [FiscalQuarter] ,
    DATEPART(qq, [FiscalDate]) as [FiscalQuarterNumber] ,
    'Q' + CONVERT(VARCHAR(2),DATEPART(qq, [FiscalDate])) as [FiscalQuarterName] ,
    [FiscalYearSequenceReversed],
	DATEPART(yyyy, [FiscalDate]) as [FiscalYear],
	CONVERT(VARCHAR(10), [Date], 101) as [DateSlicer], --MM/DD/YYYY
	CASE WHEN DATEPART(week, [Date]) = DATEPART(week, GETDATE()) AND YEAR([Date]) = YEAR(GETDATE()) THEN 'Current Week'
		 WHEN DATEPART(week, DATEADD(week,1, [Date])) = DATEPART(week, GETDATE()) AND YEAR(DATEADD(week,1,[Date])) = YEAR(GETDATE()) THEN 'Prior Week'
		 ELSE NULL 
		 END
	 as [WeekSlicer],
	CASE WHEN DATEPART(month, [Date]) = DATEPART(month, GETDATE()) AND YEAR([Date]) = YEAR(GETDATE()) THEN 'Current Month'
		 WHEN DATEPART(month, DATEADD(MONTH,1,[Date])) = DATEPART(month, GETDATE()) AND YEAR(DATEADD(MONTH,1,[Date])) = YEAR(GETDATE()) THEN 'Prior Month'
		 ELSE NULL 
		 END
	 as [MonthSlicer],
	CASE WHEN DATEPART(quarter, [Date]) = DATEPART(quarter, GETDATE()) AND YEAR([Date]) = YEAR(GETDATE()) THEN 'Current Quarter'
		 WHEN DATEPART(quarter, DATEADD(quarter,1,[Date])) = DATEPART(quarter, GETDATE()) AND YEAR(DATEADD(quarter,1,[Date])) = YEAR(GETDATE()) THEN 'Prior Quarter'
		 ELSE NULL 
		 END
	 as [QuarterSlicer],
	CASE WHEN YEAR([Date]) = YEAR(GETDATE()) THEN 'Current Year'
		 WHEN YEAR(DATEADD(year,1,[Date])) = YEAR(GETDATE()) THEN 'Prior Year'
		 ELSE NULL 
		 END
	 as [YearSlicer],
	CASE WHEN DATEPART(week, [FiscalDate]) = DATEPART(week, GETDATE()) AND YEAR([FiscalDate]) = YEAR(GETDATE()) THEN 'Current Week'
		 WHEN DATEPART(week, DATEADD(week,1, [FiscalDate])) = DATEPART(week, GETDATE()) AND YEAR(DATEADD(week,1,[FiscalDate])) = YEAR(GETDATE()) THEN 'Prior Week'
		 ELSE NULL 
		 END
	 as [FiscalWeekSlicer],
    --This is just redundant 
	--CASE WHEN DATEPART(month, [Date]) = DATEPART(month, GETDATE()) AND YEAR([FiscalDate]) = YEAR(GETDATE()) THEN 'Current Month'
	--	 WHEN DATEPART(month, DATEADD(MONTH,-1,[Date])) = DATEPART(month, GETDATE()) AND YEAR(DATEADD(MONTH,-1,[FiscalDate])) = YEAR(GETDATE()) THEN 'Prior Month'
	--	 ELSE NULL 
	--	 END
	-- as [FiscalMonthSlicer],
	CASE WHEN DATEPART(quarter, [FiscalDate]) = DATEPART(quarter, GETDATE()) AND YEAR([FiscalDate]) = YEAR(GETDATE()) THEN 'Current Quarter'
		 WHEN DATEPART(quarter, DATEADD(quarter,1,[FiscalDate])) = DATEPART(quarter, GETDATE()) AND YEAR(DATEADD(quarter,1,[FiscalDate])) = YEAR(GETDATE()) THEN 'Prior Quarter'
		 ELSE NULL 
		 END
	 as [FiscalQuarterSlicer],
	CASE WHEN YEAR([FiscalDate]) = YEAR(GETDATE()) THEN 'Current Year'
		 WHEN YEAR(DATEADD(year,1,[FiscalDate])) = YEAR(GETDATE()) THEN 'Prior Year'
		 ELSE NULL 
		 END
	 as [FiscalYearSlicer],
    CASE WHEN [Date] < datediff(d, 0, getdate()) THEN 'Past' 
         WHEN [Date] = datediff(d, 0, getdate()) THEN 'Current'
         WHEN [Date] > datediff(d, 0, getdate()) THEN 'Future'
         ELSE 'Unknown'
    END [FutureFilter] -- more logic will be needed downstream to verify.
 
FROM Calendar_and_Fiscal_Dates
WHERE [Date] <= '2049-12-31' --As end date
