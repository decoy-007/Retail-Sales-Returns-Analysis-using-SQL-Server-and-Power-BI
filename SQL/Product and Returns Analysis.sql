--=========================================
-- Product and Returns analysis
--=========================================

-- Product ranking analysis

WITH Ranking AS(
SELECT
    p.product_id,
    p.product_name,
    SUM(o.net_amount) [Total Revenue(Completed Orders)],
    COUNT(order_id) [Total Orders(Completed Orders) ]
FROM V_Retail_Products p
JOIN V_Retail_Orders o
ON p.product_id = o.product_id
WHERE order_status = 'Completed'
GROUP BY p.product_id , p.product_name
)
SELECT*,
CAST(
    100.0 * [Total Revenue(Completed Orders)] /
    NULLIF(SUM([Total Revenue(Completed Orders)]) OVER (), 0)
    AS DECIMAL(10,2)
) AS [Revenue Contribution Percent],
RANK() OVER(ORDER BY [Total Revenue(Completed Orders)] DESC) Rank
FROM Ranking

SELECT
    refund_status,
    COUNT(DISTINCT return_id) AS Total_Returns,
    SUM(return_quantity) AS Total_Units_Returned
FROM V_Retail_Returns
GROUP BY refund_status
ORDER BY Total_Returns DESC;

-----------------------------------------------------------------------------
-- Product Return Analysis

SELECT
    o.product_id,
    p.product_name,
    COUNT(*)[Total Returns],
    SUM(return_quantity) [Return Quantity]
FROM V_Retail_Returns r
INNER JOIN V_Retail_Orders o
ON r.order_id = o.order_id
INNER JOIN V_Retail_Products p
ON o.product_id = p.product_id
GROUP BY p.product_name , o.product_id
ORDER BY [Return Quantity] DESC

-------------------------------------------------------------------------------------

-- Sales Channel Analysis

WITH ChannelOrders AS (
    SELECT
        sales_channel,
        COUNT(DISTINCT order_id) AS Total_Orders
    FROM V_Retail_Orders
    WHERE order_status = 'Completed'
    GROUP BY sales_channel
),
ChannelReturnedOrders AS (
    SELECT
        o.sales_channel,
        COUNT(DISTINCT o.order_id) AS Returned_Orders
    FROM V_Retail_Returns r
    INNER JOIN V_Retail_Orders o
        ON r.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.sales_channel
)
SELECT
    c.sales_channel,
    c.Total_Orders,
    COALESCE(r.Returned_Orders, 0) AS Returned_Orders,

    CAST(
        100.0 * COALESCE(r.Returned_Orders, 0)
        / NULLIF(c.Total_Orders, 0)
        AS DECIMAL(10,2)
    ) AS Return_Rate_Percent

FROM ChannelOrders c
LEFT JOIN ChannelReturnedOrders r
    ON c.sales_channel = r.sales_channel
ORDER BY Return_Rate_Percent DESC;
