CREATE VIEW V_Retail_Customers AS

WITH CustomerDupes AS(
SELECT*,
ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY customer_id) RN
FROM retail_customers
)
SELECT
customer_id,
TRIM(customer_name) customer_name,
TRIM(email) email,
phone,
CASE 
	WHEN UPPER(TRIM(city)) IN ('JHB','JOBURG')
		THEN 'Johannesburg'
	ELSE TRIM(city)
	END city,
TRIM(province) province,
CASE 
	WHEN UPPER(TRIM(customer_segment)) IN ('CORPORATE')
		THEN 'Corporate'
	WHEN UPPER(TRIM(customer_segment)) IN ('SMALL BUSINESS' ,'SMB')
		THEN 'Small Business'
	WHEN UPPER(TRIM(customer_segment)) IN ('CONSUMER')
		THEN 'Consumer'
	ELSE customer_segment
END AS customer_segment,
    DATEADD(DAY, signup_date - 2, CAST('1900-01-01' AS DATE))
        AS signup_date,
TRIM(account_status) account_status
FROM CustomerDupes
WHERE RN = 1
