use NORTHWND

--Seleccionar el 50% de los registros

select top 50 percent * from Orders

select top 25 percent * from Orders

--Seleccionar los primeros 3 clientes de alemania

Select top 3 *
from Customers
where Country = 'Germany'
order by CustomerID

--Seleccionar el producto con un precio mayor
select * from products
order by UnitPrice desc

--Muestra el precio mas alto de los productos (max)
select max(unitprice) as 'Precio Maximo' from Products

--Mostrar el precio minimo de los productos
select min(unitprice) as 'Precio Minimo' from Products

--Seleccionar todas las ordenes de compra
Select * from Orders;

--Seleccionar el numero total de ordenes (count)

select count(*) as 'Total de ordenes' from orders 

select count(ShipRegion) as 'Total de ordenes' from orders

--Seleccionar todas aquellas ordenes donde la region de envio no sea null

select * from Orders
where ShipRegion is not null

--Seleccionar de forma ascendente los productos por precio 
select * from Products
order by UnitPrice ASC;

--Seleccionar el numero de precios de todos los precios 
select count(distinct unitprice) from Products

--Contar todos los diferentes paises de los clientes
select count(distinct country) from Customers

--Seleccionar todos los registros de orders details calculando su importe
--(Campo Calculado)
SELECT *,
Quantity * UnitPrice
FROM [Order Details];

--Seleccionar el total en dinero que ha vendido la empresa
SELECT SUM(Quantity * UnitPrice)
FROM [Order Details];

--Seleccionar el total de venta del producto chang
select sum(UnitPrice * Quantity) as Total
from [Order Details]
where ProductID = 2

--Seleccionar el promedio de los precios de los productos (avg)
select AVG(UnitPrice) 
from Products;

--Seleccionar el promedio y el total de los productos
select AVG(UnitPrice) from Products
--Seleccionar el promedio total y el total de venta de los productos 41,60 y 31
select SUM(UnitPrice) as total, avg (UnitPrice * Quantity)
from [Order Details]
where ProductID IN (41, 60, 31)

--Seleccionar el numero de ordenes realizadas entre 1996 y 1997
select count(*) from Orders 
where OrderDate >= '1996 - 01 -01' and OrderDate <= '1997-12-31'  