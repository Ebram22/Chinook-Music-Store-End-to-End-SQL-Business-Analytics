-- Geographic_Analysis -- done
Create View Geographic_Analysis as
Select 
    i.BillingCountry as Country,
    Count(distinct i.CustomerId) as Total_Customers,
    Count(distinct i.InvoiceId) as Total_Orders,
    SUM(il.Quantity) as Total_Quantity,
    Round(Sum(il.UnitPrice * il.Quantity),2) as Total_Sales,
    Round(SUM(il.UnitPrice * il.Quantity) / Count(distinct i.InvoiceId), 2) as Average_Order_Value
From invoice i
Inner join invoiceline il ON i.InvoiceId = il.InvoiceId
Group by i.BillingCountry
Order by Total_Sales desc;

-- Basket_Segmentation -- done
Create View Basket_Segmentation as
With Basket_Sizes as (
Select 
	InvoiceId,
	SUM(Quantity) as Items_Count
From invoiceline
Group by InvoiceId
)
Select 
    Count(Case When Items_Count between 1 and 3 then InvoiceId end) as "Small_Basket",
    Count(Case When Items_Count between 4 and 9 then InvoiceId end) as "Medium_Basket",
    Count(Case When Items_Count >= 10 then InvoiceId end) as "Large_Basket"
From Basket_Sizes;