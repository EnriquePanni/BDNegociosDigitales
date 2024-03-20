use NORTHWND

--Seleccionar todas las ordenes de compra
--Mostrando las fechas ordenes de compra
--Nombre de shipper y el nombre del cliente
--al que se le ha vendido (innerjoin -  a tres tablas)

Select c.CompanyName as 'Cliente', o.OrderDate as 'Fecha de Orden', s.companyName as 'Nombre Flete' from
Customers as c
inner join orders as o
on c.CustomerID = o.CustomerID
inner join Shippers as s
on o.ShipVia = s.ShipperID

--Seleccionar el nombre del producto y su categoria

select c.CategoryName, p.ProductName from
categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
--Listar el nombre de los productos, la fecha de la orden,
--los nombres de los productos que fueron enlistados

select c.CompanyName, o.OrderDate from
Customers as c
inner join orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on o.OrderID = od.OrderID
inner join Products as p
on od.ProductID = p.ProductID

--Seleccionar los nombres completos de los empleados,
--los nombres de los productos que vendio y la cantidad de ellos
select 
    concat(e.FirstName, ' ', e.LastName) as NombreCompletoEmpleado,
    p.ProductName,
    od.Quantity
from
    Employees as e
    inner join Orders as O on E.EmployeeID = O.EmployeeID
    inner join [Order Details] as OD on O.OrderID = OD.OrderID
    inner join Products as P on OD.ProductID = P.ProductID;

-- Seleccionar los nombres completos de los empleados,
-- los nombres de los productos que vendio y la cantidad
-- de ellos y calcular el importe,
-- pero solos enviados a suiza, alemania y francia
-- Agrupados por la cantidad total de ordenes hechas por los
-- empleados

SELECT 
    concat(E.FirstName, ' ', E.LastName) AS NombreCompletoEmpleado,
    P.ProductName,
    count(OD.Quantity) AS CantidadTotal,
    count(OD.Quantity * OD.UnitPrice) AS ImporteTotal,
    O.ShipCountry
from 
    Employees AS E
    inner join Orders AS O ON E.EmployeeID = O.EmployeeID
    inner join [Order Details] AS OD ON O.OrderID = OD.OrderID
    inner join Products AS P ON OD.ProductID = P.ProductID
where
    O.ShipCountry in ('Switzerland', 'Germany', 'France')
group by 
    E.EmployeeID, E.FirstName, E.LastName, P.ProductName, O.ShipCountry;

-- Seleccionar el numero de ordenes enviadas a alemania, suiza y francia
-- agrupadas por el empleado
select count(*) as 'Total de Ordenes', 
CONCAT(e.FirstName, ' ', e.LastName)
as 'Nombre Completo'
from
employees as e
inner join orders as o
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
inner join Products as p
on p.ProductID = od.ProductID
where o.ShipCountry in ('France', 'Germany','Switzerland')
group by CONCAT(e.FirstName, ' ', e.LastName)

--seleccionar el total de dinnero a que se le 
--han vendido a cada uno de los clientes 
--de 1996

select companyName as 'Cliente',
sum(UnitPrice * Quantity) as 'Total de venta'
from
[Order Details] as od
inner join
Orders as o
on od.OrderID = o.OrderID
inner join Customers as c
on o.CustomerID = c.CustomerID
where year(o.OrderDate) = '1996'
group by companyName
order by 2 desc

--Seleccionar el total de dinero que se le
--han vendido a cada uno de los clientes
--por cada 

select 
    C.CustomerID,
    C.CompanyName,
    year(O.OrderDate) as Año,
    sum(OD.Quantity * OD.UnitPrice) as TotalVenta
from 
    Customers as C
    INNER JOIN Orders as O on C.CustomerID = O.CustomerID
    INNER JOIN [Order Details] as OD on O.OrderID = OD.OrderID
group by
    C.CustomerID, C.CompanyName, year(O.OrderDate)
order by
    C.CustomerID, year(O.OrderDate);

	--Por categoria de producto
	select c.CategoryName, sum()  * from Categories as c
	inner join Prducts as p
	on p.CategoryID = c.CategoryID
	inner join [Order Details]

	--Seleccionar el numero de productos, el nombre del producto y el
	--Nombre de categoria, ordenados de forma ascendentes con respecto
	--al nombre de la categoria
	select p.ProductID, p.ProductName, c.CategoryName from Products as p
	inner join Categories as c
	on p.CategoryID = c.CategoryID
	order by c.CategoryName asc

--left join

Select c.CompanyName, o.OrderID, o.OrderDate, o.CustomerID from Customers as c 
inner join orders as o 
on c.CustomerID = o.CustomerID

--Alias de Columnas y Alias de Tablas
--Seleccionar el nombre del prodcuto, su stock y su precio
select ProductName as 'Nombre del Producto', UnitsInStock as stock, UnitPrice precio 
from products as p
inner join [Order Details] as od 
on p.ProductID = od.ProductID