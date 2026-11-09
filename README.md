This project focuses on analysing retail sales and returns data using Microsoft SQL Server and Power BI.
The objective was to transform a messy retail dataset into structured, reliable data and develop an interactive Power BI dashboard to uncover insights into sales performance, customer purchasing behaviour, product performance and product returns.

The project demonstrates the end-to-end data analytics process, from data cleaning and preparation to SQL analysis, data validation and interactive dashboard development.

Tools & Technologies

Microsoft SQL Server: Data cleaning, transformation, validation and exploratory data analysis.
Power BI: Data modelling, DAX calculations, interactive dashboards and data visualisation.
DAX: Creation of calculated measures and business KPIs.
Project Workflow

1. Data Cleaning & Preparation (SQL Server)

The original dataset contained several data-quality issues that needed to be addressed before analysis.
Key cleaning activities included:
Identifying and investigating duplicate customer and order records.
Standardising inconsistent city names and customer segments.
Handling missing and invalid values.
Converting mixed date formats, including Excel serial dates, into standard SQL date values.
Converting numeric fields such as quantities, unit prices and revenue amounts into appropriate data types.
Standardising categorical values such as sales channels, payment methods and order statuses.
Preparing SQL views for customers, orders, products and returns.
Investigating product master data inconsistencies.

2. Exploratory Data Analysis (SQL Server)
SQL queries were developed to investigate business performance and answer key questions.
Analysis included:
Total completed sales revenue and orders.
Revenue performance by month and year.
Month-over-month revenue growth.
Sales performance by province and sales channel.
Revenue by customer segment.
Top-performing products.
Top customers by revenue.
Customer purchasing frequency
Returned quantities, products and return reasons.
Revenue validation and reconciliation.

3. Data Quality & Validation
Data validation was performed to ensure the reliability of the analysis.
Examples included:
Comparing expected net amounts against recorded net amounts.
Checking whether calculated revenue aligned with transaction quantities, prices and discounts.
Investigating duplicate product names associated with different product IDs.
Comparing product master prices against recorded transaction prices.
Reconciling SQL results with Power BI visualisations.

4. Power BI Dashboard Development
An interactive Power BI dashboard was developed across three pages.
Page 1: Executive Summary
Provides an overview of overall retail business performance.
Key metrics and visualisations:
Completed Revenue
Completed Orders
Units Sold
Average Order Value
Unique Customers
Monthly Revenue Trends
Revenue by Sales Channel
Revenue by Province
Revenue by Customer Segment
Customer Purchasing Frequency

Page 2: Customer & Product Analysis
Focuses on understanding customer behaviour and identifying product performance.
Key visualisations:
Revenue by Customer Segment
Top 10 Products by Revenue
Top 10 Customers by Revenue
Revenue per Customer
Units Sold

Page 3: Returned Orders Analysis
Focuses on understanding product returns and their impact on the business.
Key analysis areas:
Returned Order Revenue
Total Returns by Product
Returned Quantities
Return Reasons
Refund Status
Product Return Performance
Key Business Findings & Insights

1. Overall Sales Performance

The business generated approximately R15.46 million in completed revenue.
Approximately 10,000 units were sold.
The dataset contained approximately 3,000 completed orders.
Approximately 1,000 unique customers were identified.
The average order value was approximately R4,610.

2. Sales Channel Performance
Partner and Online channels were the largest revenue contributors, generating approximately R5.39 million and R5.23 million respectively.

Retail generated approximately R4.82 million.

This indicates that all three channels contributed meaningfully to overall sales, with Partner and Online slightly ahead of Retail.

3. Regional Sales Performance

Gauteng was the strongest-performing province, generating approximately R4.5 million in completed revenue.
Free State followed with approximately R2.0 million, while North West and Eastern Cape each generated approximately R1.7 million.

This highlights Gauteng as the largest regional revenue contributor in the dataset.

4. Customer Segment Performance

Corporate customers generated approximately R5.2 million in revenue, followed closely by Consumer customers at R5.1 million.

Small Business customers contributed approximately R4.8 million.
Revenue was relatively evenly distributed across the three customer segments.

5. Product Performance
Core Webcam was the highest-revenue product by name, generating approximately R742,391.87 across two different product IDs.

Other strong-performing products included:

Tekpro Webcam

Zenith 24in Monitor

Orbit Mechanical Keyboard

Nova Wireless Mouse

6. Data Quality Finding: Duplicate Product Names
During the investigation, two different product IDs were identified with the same product name, category and brand:
P0014 – Core Webcam
P0016 – Core Webcam

Although their descriptive attributes were identical, their master unit prices differed significantly.
P0014 had a master price of R4,948.04, while P0016 had a master price of R368.30.
Further investigation showed that their recorded transaction prices also differed from their respective master prices.
This finding highlighted the importance of validating product master data before performing product-level analysis.
The records were retained pending further verification rather than being incorrectly merged or deleted.

Skills Demonstrated

SQL querying and data manipulation
Data cleaning and transformation
SQL views and Common Table Expressions (CTEs)
Data validation and reconciliation
Exploratory Data Analysis (EDA)
Business performance analysis
DAX calculations and measures
Power BI dashboard development
Data visualisation
Data quality investigation
Translating business data into actionable insights
