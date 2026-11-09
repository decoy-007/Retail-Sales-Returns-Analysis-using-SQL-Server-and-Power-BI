--=============================================
-- Time series analysis
--=============================================

-- Monthly Revenue Analysis

WITH MonthlyRevenue AS(
SELECT
DATEFROMPARTS(YEAR(order_date), MONTH(order_date),1) [order date],
SUM(net_amount) [Total Revenue]
FROM V_Retail_Orders
WHERE order_status = 'Completed'
GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date),1)
),
PreviousMonth AS(
SELECT*,
LAG([Total Revenue],1)OVER(ORDER BY [order date]) [Previous Revenue]
FROM MonthlyRevenue
)
SELECT*,
CAST(ROUND(100.0 *([Total Revenue] - [Previous Revenue])/ NULLIF([Previous Revenue],0),2)AS decimal(10,2)) AS [MoM growth percent],
CASE 
	WHEN [Previous Revenue] IS NULL THEN 'No Previous Month'
	WHEN [Total Revenue] < [Previous Revenue] THEN 'Decrease'
	WHEN [Total Revenue] > [Previous Revenue] THEN 'Increase'
	ELSE 'No Change'
END [Performance Indicator]
FROM PreviousMonth;

----------------------------------------------------------------------------

-- Comparing Monthly revenue Yearly 
WITH MonthlyRevenue AS(
SELECT
DATEFROMPARTS(YEAR(order_date),MONTH(order_date),1) [order date],
SUM(net_amount) [Total Revenue]
FROM V_Retail_Orders
WHERE order_status ='Completed'
GROUP BY DATEFROMPARTS(YEAR(order_date),MONTH(order_date),1)
),
PreviousYear AS(
SELECT*,
LAG([Total Revenue] ,12)OVER(ORDER BY [order date]) [Previous Year Revenue]
FROM MonthlyRevenue
)
SELECT*,
CAST(ROUND(100*([Total Revenue] - [Previous Year Revenue])/NULLIF([Previous Year Revenue],0),2)AS decimal(10,2)) [YoY Growth Percent],
CASE
	
	WHEN [Total Revenue] < [Previous Year Revenue] THEN 'Decrease'
	WHEN [Total Revenue] > [Previous Year Revenue] THEN 'Increase'
	ELSE 'No Change'
END [Performance Indicator]
FROM PreviousYear;

----------------------------------------------------------------------
-- Yearly Revenue Analysis

WITH YearlyRevenue AS (
    SELECT
        YEAR(order_date) AS Order_Year,
        SUM(net_amount) AS Total_Revenue
    FROM V_Retail_Orders
    WHERE order_status = 'Completed'
      AND order_date IS NOT NULL
    GROUP BY YEAR(order_date)
),
PreviousYear AS (
    SELECT
        Order_Year,
        Total_Revenue,
        LAG(Total_Revenue) OVER (
            ORDER BY Order_Year
        ) AS Previous_Year_Revenue
    FROM YearlyRevenue
)
SELECT
    Order_Year,
    Total_Revenue,
    Previous_Year_Revenue,
    CAST(
        ROUND(
            100.0 * (Total_Revenue - Previous_Year_Revenue)
            / NULLIF(Previous_Year_Revenue, 0),
            2
        ) AS DECIMAL(10,2)
    ) AS YoY_Growth_Percent
FROM PreviousYear
ORDER BY Order_Year;

--------------------------------------------------------------------