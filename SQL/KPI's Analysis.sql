--========================================
-- KPI's Analysis
--========================================

-- Product KPI
SELECT
    p.product_id,
	p.product_name,
	SUM(o.net_amount) [Total Revenue (Completed Orders)]
FROM V_Retail_Orders o
	INNER JOIN V_Retail_Products p
	ON o.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY  p.product_id, p.product_name
ORDER BY [Total Revenue (Completed Orders)] DESC

----------------------------------------------------------

-- Orders KPI
SELECT
YEAR(order_date) [Order date],
SUM(net_amount) [Total Revenue],
SUM(quantity) [Total Units sold],
COUNT(*) [Total Orders]
FROM V_Retail_Orders
WHERE order_status = 'Completed' 
GROUP BY YEAR(order_date);

----------------------------------------------------------

-- Total Revenue for Completed Orders
SELECT
SUM(net_amount) [Total Revenue (Completed Orders)]
FROM V_Retail_Orders
WHERE order_status = 'Completed'

--------------------------------------------------------------

-- Total Revenue for returned orders
SELECT
SUM(net_amount) [Total Revenue (Returned Orders)]
FROM V_Retail_Orders
WHERE order_status = 'Returned'