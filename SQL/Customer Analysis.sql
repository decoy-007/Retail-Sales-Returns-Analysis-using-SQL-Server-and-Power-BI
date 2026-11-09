--========================================
-- Customer Analysis
--========================================

-- customer segment analysis
SELECT
	c.customer_segment,
	SUM(o.net_amount) [Total Revenue (Completed Orders)],
	AVG(o.net_amount) [Average Net],
	COUNT(order_id) [Total Orders],
	SUM(o.quantity) [Total Units Sold],
	COUNT(DISTINCT o.customer_id) [Unique Customers]
FROM V_Retail_Orders o
	JOIN V_Retail_Customers c
	ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_segment
ORDER BY [Total Revenue (Completed Orders)] DESC

----------------------------------------------------------------

-- Top 20 Customers with highest spending
SELECT TOP 20
	c.customer_id,
	c.customer_name,
	SUM(o.net_amount) [Total Revenue],
	COUNT(o.order_id) [Total Orders],
	SUM(o.quantity) [Total Purchased Units]
FROM V_Retail_Customers c
	JOIN V_Retail_Orders o
	ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY [Total Revenue] DESC

-------------------------------------------------------------------
-- Customer Summary analysis

WITH CustomerSummary AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.customer_segment,
        SUM(o.net_amount) AS Total_Spending,
        COUNT(DISTINCT o.order_id) AS Total_Orders
    FROM V_Retail_Customers c
    INNER JOIN V_Retail_Orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.customer_segment
)
SELECT
    *,
    CASE
        WHEN Total_Orders >= 7 THEN 'High Frequency Customer'
        WHEN Total_Orders >= 4 THEN 'Medium Frequency Customer'
        WHEN Total_Orders >= 2 THEN 'Repeat Customer'
        ELSE 'One Completed Order'
    END AS Purchase_Frequency
FROM CustomerSummary
ORDER BY Total_Spending DESC;

-------------------------------------------------------------------

-- Province revenue and average customer spending analysis
SELECT
	province,
	COUNT(DISTINCT customer_id)[Unique Customers],
	SUM(net_amount) [Total Revenue (Completed Orders)],
	CAST(ROUND(SUM(net_amount)/NULLIF(COUNT(DISTINCT customer_id),0),2)AS decimal(12,3))[Revenue Per customer]
FROM V_Retail_Orders
WHERE order_status = 'Completed'
GROUP BY province
ORDER BY [Total Revenue (Completed Orders)] DESC
