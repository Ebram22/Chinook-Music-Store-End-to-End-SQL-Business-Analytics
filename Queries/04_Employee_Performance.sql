-- Employee & Sales Rep Performance
Create view  Employee_and_Sales_Rep_Performance as -- done
with employee_performance as(
select e.EmployeeID,
		sum(Total) as Total_Sales,
        count(distinct i.customerid) as Assigned_Customers,
        round(sum(Total)/count(distinct i.customerid),2) as Avg_Revenue_per_Customer
from employee e
	inner join customer c on e.EmployeeId=c.SupportRepId
    inner join invoice i on i.CustomerId=c.CustomerId
group by e.EmployeeID
)
select concat(e.FirstName,e.LastName) as Sales_Rep,
		COALESCE(CONCAT(m.FirstName, ' ', m.LastName), 'Top Executive') AS Manager_Name,
		Total_Sales,
        Assigned_Customers,
        Avg_Revenue_per_Customer
from employee_performance ep 
	inner join employee e on ep.EmployeeID=e.EmployeeID
	Left join employee m on m.employeeid=e.Reportsto
order by Total_Sales desc


