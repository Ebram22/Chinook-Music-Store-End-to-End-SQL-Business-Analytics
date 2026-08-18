Create view Customer_Segmentation_Cohort_Analysis as
with Joined_Year as(
Select customerid,
		Date(min(invoicedate)) as Joined_year
from invoice i
group by customerid
),
Cohot_Analysis as(
Select jy.customerid,
		Year(Joined_year) as Joined_Year,
        Year(invoicedate) as invoice_date,
        total as Total_Sales
from Joined_year jy
	inner join invoice i on jy.customerid=i.customerid
)
Select  Joined_Year,
		count(distinct customerid) as Total_Customers,
        SUM(CASE WHEN invoice_date = 2021 THEN Total_Sales ELSE 0 END) AS Sales_2021,
		SUM(CASE WHEN invoice_date = 2022 THEN Total_Sales ELSE 0 END) AS Sales_2022,
		SUM(CASE WHEN invoice_date = 2023 THEN Total_Sales ELSE 0 END) AS Sales_2023,
		SUM(CASE WHEN invoice_date = 2024 THEN Total_Sales ELSE 0 END) AS Sales_2024,
		SUM(CASE WHEN invoice_date = 2025 THEN Total_Sales ELSE 0 END) AS Sales_2025
from Cohot_Analysis
group by Joined_year