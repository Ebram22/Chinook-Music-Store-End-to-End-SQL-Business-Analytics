-- Financial & Customer Concentration Risk - 80/20 Rule
with Customer_Sales as(
Select Customerid,
		sum(Total) as Total_Sales,
        PERCENT_RANK() OVER (ORDER BY sum(Total) DESC) AS rank_pct
from invoice
group by Customerid
)
Select sum(case when rank_pct < 0.2 then  Total_Sales else 0 end) as "Top_Group",
	   sum(case when rank_pct >= 0.2 then  Total_Sales else 0 end) as "other_Group",
      round(sum(case when rank_pct <= 0.2 then  Total_Sales else 0 end)*100/SUM(Total_Sales),2) as Pareto_Percentage
from Customer_Sales


-- % Repeated Customers
Create view Repeated_Customers as   -- done
with Repeat_Customers as(
Select Customerid,
	   count(invoiceid) as Total_Orders
From invoice
Group by Customerid
Having Total_Orders > 1
)
Select 
    count(*) AS Repeat_Customer_Count,
    (Select Count(Distinct CustomerId) from customer) as Total_Registered_Customers,
    Round((Count(*) * 100.0) / (Select Count(distinct CustomerId) From customer), 2) as Repeat_Purchase_Rate_Percentage
FROM Repeat_Customers;