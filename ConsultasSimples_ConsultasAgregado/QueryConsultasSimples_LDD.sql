--SELECCIONAR TODOS LOS CLIENTES CON UNA CIUDAD QUE COMIENCE CON L 
--SEGUIDO DE TRES CARACTERES CUALQUIERA Y QUE TERMINE CON LA PALABRA "ON"
select * from 
Customers
where City like 'L___on'

--Seleccionar

use NORTHWND
select * from Products

--Seleccionar todos los productos que comiencen con la letra a o co t
select * from
Products
where ProductName like '[act]%'

--Seleccionar todos los productos que comiencen de la letra b a la g
select * from
Products
where ProductName like '[b-g]%'

--Seleccionar todos los clientes de alemania, espana y reino unido
Select * from Customers
where country in('Germany', 'Spain', 'uk')

--Seleccionar todos los clientes que no son de alemania espa;a y reino unido
--not in
select * from Customers
where Country not in ('Germany', 'Spain', 'UK')

select * from customerswhere not (country = 'Germany'
or country = 'Spain' or
Country = 'uk')

-- Instruccion between
-- seleccionar todos los productos con un precio entre 10 y 20 dolares 

select * from Products
where UnitPrice between 10 and 20

select * from Products
where UnitPrice>=10 and UnitPrice<=20

--Alias de Columnas y Alias de Tablas
--Seleccionar el nombre del prodcuto, su stock y su precio
select ProductName as 'Nombre del Producto', UnitsInStock as stock, UnitPrice precio from products

