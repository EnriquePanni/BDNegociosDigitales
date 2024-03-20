use northwind 

--1
select c.CompanyName as 'Nombre Cliente'
,min(o.OrderDate) as 'Fecha Primera compra',
sum(od.Quantity * od.UnitPrice) as 'Total de compras del cliente'
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
group by c.CompanyName
having sum(od.Quantity * od.UnitPrice) >1000
order by 'Total de compras del cliente'  desc

--2
select p.ProductName, p.UnitsInStock,
sum(od.Quantity * od.UnitPrice)
from 
Products as p 
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by p.ProductName, p.UnitsInStock
having count(od.OrderID) > 0
order by 2 desc


--Seleccionar el total de ordenes realizadas por los empleados mostrando solamente
--los que hhan vendido mas de 50 ordenes
select concat(e.FirstName, '', e.LastName) as fullname, 
COUNT(o.OrderID) as 'Total' 
from Orders as o
inner join Employees as e 
on e.EmployeeID = o.EmployeeID 
group by CONCAT(e.FirstName, ' ', e.LastName)
having COUNT(o.OrderID) > 50


--Examen 
select concat(e.FirstName, '', e.LastName) as fullname, 
COUNT(o.OrderID) as 'Total' 
from Orders as o
inner join Employees as e 
on e.EmployeeID = o.EmployeeID 
inner join [Order Details] as od
on od.OrderID = od.OrderID
group by CONCAT(e.FirstName, ' ', e.LastName)
having COUNT(o.OrderID) > 50

--4
select p.ProductName, COUNT(od.ProductID) as totalVeces
from Products as p 
left join 
[Order Details] as od
on od.ProductID = p.ProductID
group by p.ProductName
having COUNT(od.ProductID) >=1
order by 2 desc

--5
select concat(e.FirstName, '', e.LastName) as fullname, 
sum(od.Quantity * od.UnitPrice) as 'Total' 
from Orders as o
inner join Employees as e 
on e.EmployeeID = o.EmployeeID 
inner join [Order Details] as od
on od.OrderID = od.OrderID
where YEAR(o.OrderDate) = '1996'
group by CONCAT (e.FirstName, '', e.LastName)
having sum(od.Quantity * od.UnitPrice) > 500
order by 'Total' desc 


--Vistas 
create view vistaConsultas1
as
select c.CompanyName as 'Nombre Cliente'
,min(o.OrderDate) as 'Fecha Primera compra',
sum(od.Quantity * od.UnitPrice) as 'Total de compras del cliente'
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
group by c.CompanyName
having sum(od.Quantity * od.UnitPrice) >1000

select * from vistaConsultas1
where [Nombre Cliente] = 'Vaffeljernet'

select sum([Total de compras del cliente]) as total
from vistaConsultas1
where YEAR([Fecha Primera compra]) = '1997'