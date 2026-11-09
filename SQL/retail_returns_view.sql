CREATE VIEW V_Retail_Returns AS

WITH ReturnDuplicates AS
(
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY return_id
            ORDER BY return_id
        ) AS RN
    FROM retail_Returns
)

SELECT 
    return_id,
    order_id,

    CASE
        WHEN FLOOR(TRY_CONVERT(DECIMAL(10,5), return_date)) IS NOT NULL
        THEN DATEADD(
            DAY,
            CAST(
                FLOOR(TRY_CONVERT(DECIMAL(10,5), return_date))
                AS INT
            ) - 2,
            CAST('19000101' AS DATE)
        )

        WHEN TRY_CONVERT(DATE, return_date, 103) IS NOT NULL
        THEN TRY_CONVERT(DATE, return_date, 103)

        WHEN TRY_CONVERT(DATE, return_date, 110) IS NOT NULL
        THEN TRY_CONVERT(DATE, return_date, 110)

        WHEN TRY_CONVERT(DATE, return_date, 106) IS NOT NULL
        THEN TRY_CONVERT(DATE, return_date, 106)

        ELSE NULL
    END AS return_date,

    return_quantity,
    TRIM(return_reason) AS return_reason,
    TRIM(refund_status) AS refund_status

FROM ReturnDuplicates

WHERE RN = 1;