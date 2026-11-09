SELECT * FROM retail_Orders;

--CHECKING DUPLICATE ORDERS 
WITH duplicates AS(
SELECT
order_id,
ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_id) RN
FROM retail_Orders
)
SELECT * 
FROM duplicates
WHERE RN > 1;

SELECT DISTINCT 
product_id
FROM retail_Orders
ORDER BY product_id DESC

--STANDARDIZING ORDER STATUS COLUMN
SELECT
    CASE 
        WHEN UPPER(TRIM(order_status)) IN ('COMPLETE')
            THEN 'Completed'
        WHEN UPPER(TRIM(order_status))IN ('CANCELED')
            THEN 'Cancelled'
        ELSE TRIM(order_status)
        END order_status
FROM retail_Orders

--STANDARDIZING CITY COLUMN 
SELECT
CASE
    WHEN UPPER(TRIM(city)) IN ('JHB','JOBURG')
        THEN 'Johannesburg'
    ELSE TRIM(city)
    END city

FROM retail_Orders

-- FIXING DATES
SELECT
CASE 
    WHEN FLOOR(TRY_CONVERT(decimal(15,5),order_date)) IS NOT NULL
    THEN DATEADD(DAY,CAST(FLOOR(TRY_CONVERT(DECIMAL(15,5),order_date))AS INT) - 2,
    CAST('1900-01-01' AS date))

    WHEN TRY_CONVERT(date,order_date,103) IS NOT NULL
    THEN TRY_CONVERT(date,order_date,103)

    WHEN TRY_CONVERT(date,order_date,110) IS NOT NULL
    THEN TRY_CONVERT(date,order_date,110)
   
   WHEN TRY_CONVERT(date,order_date,106) IS NOT NULL
   THEN TRY_CONVERT(date,order_date,106)

   WHEN TRY_CONVERT(date,order_date,111) IS NOT NULL
   THEN TRY_CONVERT(date,order_date,111)
    ELSE NULL
END order_dates
FROM retail_Orders
ORDER BY order_date 

SELECT
TRY_CONVERT(int,quantity) quantity
FROM retail_Orders


SELECT
    unit_price,
    TRY_CONVERT(
        DECIMAL(10,2),
        REPLACE(unit_price, ',', '')
    ) AS cleaned_unit_price
FROM retail_Orders
order by cleaned_unit_price


SELECT
discount,
TRY_CONVERT(decimal(10,1),REPLACE(discount,'%','')) discount_clean
FROM retail_Orders

SELECT 
gross_amount,
TRY_CONVERT(decimal(10,2),REPLACE(gross_amount,',', '')) GA
FROM retail_Orders
ORDER BY GA DESC

SELECT 
net_amount,
TRY_CONVERT(decimal(10,2),REPLACE(net_amount,',', '')) NET
FROM retail_Orders
ORDER BY net DESC

SELECT*
FROM retail_Orders;



