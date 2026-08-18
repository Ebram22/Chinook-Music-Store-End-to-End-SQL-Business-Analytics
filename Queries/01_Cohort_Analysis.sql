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
		Count(distinct customerid) as Total_Customers,
        Sum(case when invoice_date = 2021 then Total_Sales else 0 end) as Sales_2021,
		Sum(case when invoice_date = 2022 then Total_Sales else 0 end) as Sales_2022,
		Sum(case when invoice_date = 2023 then Total_Sales else 0 end) as Sales_2023,
		Sum(case when invoice_date = 2024 then Total_Sales else 0 end) as Sales_2024,
		Sum(case when invoice_date = 2025 then Total_Sales else 0 end) as Sales_2025
from Cohot_Analysis
group by Joined_year
