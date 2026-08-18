-- best_Selling_Tracks -- done
Create view best_Selling_Tracks as
Select t.name as Track_Name,
	    al.Title as Album_Title,
        g.Name as Genre_Type,
		sum(il.UnitPrice) as Total_Sales,
        sum(il.Quantity) as Total_Quantity
From track t 
	inner join genre as g on t.genreid=g.genreid
    inner join album as al on al.albumid=t.albumid
    inner join artist as ar on ar.artistid=al.artistid
    inner join invoiceline as il on il.trackid=t.trackid
Group by Track_Name,Album_Title,Genre_Type
Order by Total_Sales desc, Total_Quantity desc

-- Unsold_tracks -- done
Create View Unsold_tracks as
Select t.name as Track_Name,
        g.Name as Genre_Type
From track t 
	inner join genre as g on t.genreid=g.genreid
    left join invoiceline as il on il.trackid=t.trackid
Where il.TrackId is null