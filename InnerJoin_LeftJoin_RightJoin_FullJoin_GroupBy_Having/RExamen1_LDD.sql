--1
Select p.ProductName as 'Nombre Producto', (od.quantity * od.unitprice) as 'importe'
from [order Details] as od 
inner join Products as p
on p.Productid = od.productid
inner join Orders as o
on o.Orderid = od.Orderid
where year (o.OrderDate) = '1997'
order by 2

--2
select c.CompanyName as 'Cliente', count (*) as 'Cantidad Campos'
From orders as o
inner join Customers as c
on o.Customerid = c.customerid
group by c.CompanyName
having count(*)>1

--3
Select * from 
Products as p 
left join 
[Order Details] as od
on p.productid is null
Order by p.productName asc

--4
Select c.CategoryName, count(*) as 'total'
Categories as c
inner join Products as p
on c.Categoryid = p.Categoryid
inner join [order details] as od
on od.productid = p.productid
group by c.CateogryName
having count (*)10

--5
Select p.productName as
'Nombre producto', c.Category as 'Nombre Categoria'
from Products as p 
inner join Categories as c
on P.Categories as C.Categoryid
where p.unitprice > 50
order by 1,2