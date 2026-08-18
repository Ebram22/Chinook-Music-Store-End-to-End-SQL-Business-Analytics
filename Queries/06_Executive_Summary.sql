-- Executive & Revenue Performance

-- Total_Sales - done
Create view Total_Sales as
Select sum(total) as Total_Sales
from invoice

-- Sales_by_Country -- done
Create view Sales_by_Country
Select c.Country as Country,
		sum(Total) as Total_Sales
From invoice i 
	inner join customer c on i.CustomerId=c.CustomerId
    inner join employee e on e.EmployeeId=c.SupportRepId
Group by Country


-- Sales_growth_over_Years  -- done
Create view Sales_growth_over_Years as
with Sales_by_Year as(
Select  year(InvoiceDate) as Year_Date,
		sum(Total) as Total_Sales,
		Lag(sum(Total), 1, 0) over (order by year(InvoiceDate) asc) as Prev_Year
From invoice
Group by year(InvoiceDate)
),
Sales_growth_over_Years as(
Select Year_Date as y,
		Total_Sales as Current_Year_Sales,
		Prev_Year as Last_year_Sales,
        Total_Sales-Prev_Year as YOY,
        Round((Total_Sales-Prev_Year)/NULLIF(Prev_Year, 0),2) as ΔYOY
From Sales_by_Year
)
Select * from Sales_growth_over_Years
Order by y asc,Current_Year_Sales desc