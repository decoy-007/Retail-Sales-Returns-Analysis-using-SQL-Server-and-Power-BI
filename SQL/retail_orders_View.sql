
CREATE VIEW V_Retail_Orders AS (
SELECT 
order_id,
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
END order_date,
customer_id,
product_id,
TRY_CONVERT(int,quantity) quantity,
TRY_CONVERT(DECIMAL(10,2),REPLACE(unit_price, ',', '')) AS unit_price,
TRY_CONVERT(decimal(10,1),REPLACE(discount,'%','')) discount,
TRY_CONVERT(decimal(10,2),REPLACE(gross_amount,',', '')) gross_amount,
TRY_CONVERT(decimal(10,2),REPLACE(net_amount,',', '')) net_amount,
CASE 
    WHEN UPPER(TRIM(sales_channel)) IN ('ONLINE')
        THEN 'Online'
    WHEN UPPER(TRIM(sales_channel)) IN ('RETAIL')
        THEN 'Retail'
    WHEN UPPER(TRIM(sales_channel)) IN ('PARTNER')
        THEN 'Partner'
    ELSE TRIM(sales_channel)
END sales_channel,

CASE 
    WHEN UPPER(TRIM(payment_method)) IN ('CARD')
        THEN 'Card'
    WHEN UPPER(TRIM(payment_method)) IN ('EFT')
        THEN 'EFT'
    WHEN UPPER(TRIM(payment_method)) IN ('CASH')
        THEN 'Cash'
    WHEN UPPER(TRIM(payment_method)) IN ('DIGITAL WALLET')
        THEN 'Digital Wallet'
    ELSE TRIM(payment_method)
END payment_method,

CASE 
     WHEN UPPER(TRIM(order_status)) IN ('COMPLETE')
         THEN 'Completed'
     WHEN UPPER(TRIM(order_status))IN ('CANCELED')
         THEN 'Cancelled'
     ELSE TRIM(order_status)
END order_status,

CASE
    WHEN UPPER(TRIM(city)) IN ('JHB','JOBURG')
        THEN 'Johannesburg'

         WHEN UPPER(TRIM(city)) IN ('CAPETOWN')
        THEN 'Cape Town'
    WHEN UPPER(TRIM(city)) IN ('PRETORIA CBD')
        THEN 'Pretoria'

    ELSE TRIM(city)
END city,

TRIM(province) province,

CASE 
    WHEN UPPER(TRIM(delivery_method)) IN ('COURIER')
        THEN 'Courier'
    WHEN UPPER(TRIM(delivery_method)) IN ('SAME DAY')
        THEN 'Same Day'
    WHEN UPPER(TRIM(delivery_method)) IN ('COLLECTION')
        THEN 'Collection'
    ELSE TRIM(delivery_method)
END delivery_method

FROM retail_Orders
WHERE order_id IN (
    SELECT order_id
    FROM retail_Orders
    WHERE order_id IS NOT NULL
    GROUP BY order_id
    HAVING COUNT(*) = 1
)
)
