USE pruebaentornos


--Insertar datos a partir de una consulta
select  * from categoria

insert into categoriaCopia (categoriaid, nombre)
select idCategoria, descripcion from categoria


--Actualizacion de datos sql.lmd

select * from Producto

insert into Producto
values(1, 'Salchicha', 600, 12, 1)

insert into Producto
values(1, 'Paleta de Pollo', 22, 56, 8)

insert into Producto
values(3, 'Refrigerador', 3000, 22, 1),
	(3, 'Chilindrina', 23, 43, 1),
	(3,'Terrible Mezcal', 200, 12, 1),
	(3,'Leche de Burra',2350, 3, 1)

	select * from Producto

	update producto
	set idproducto = 2 
	where nombre = 'Paleta de Pollo'

	update producto
	set idproducto = 4
	where nombre = 'Chilindrina'

	update producto
	set idproducto = 5
	where nombre = 'Terrible mezcal'

	update producto
	set idproducto = 6
	where nombre = 'Leche de burra'

	update producto
	set nombre = 'Salchicha Grande',
	existencia = 20
where idProducto = 1

	alter table producto
	add constraint pk_producto2
	primary key(idproducto)

	--Eliminar registros de una tabla

/*
	delete from tabla
	where expresion
*/

select * from producto

delete from producto 
where idProducto = 4

delete from producto 
where nombre = 'Salchicha Grande'

delete from producto
where precio >=3 and precio<=22

delete from producto
where existencia >=3 and existencia<=12

--Consultas Simples con Select -SQL-LMD
use NORTHWND

--Seleccionar todos los clientes
select * from Customers

--Seleccionar todos los paises de los clientes (distinct)
select country from Customers

select distinct country from customers

--Selecciona el numero de paises de donde son mis clientes(count)

select count(*) from customers

select count(country) from customers

select count(distinct country) from customers

--Seleccionar el cliente que tenga un id Anton

select * from Customers
where CustomerID = 'ANTON'

--Seleccionar todos los clientes de Mexico 

Select * from Customers
where country = 'Mexico'

--Seleccionar todos los registros de los clientes de berlin
Select CompanyName, city, country from Customers
where city = 'berlin'

--Order by
--Seleccionar todos los productos ordenados por precio

select * from Products
order by UnitPrice

--Seleccionar todos los productos ordenados por el precio de mayor a menor
Select * from products
order by UnitPrice DESC

--Seleccionar todos los productos alfabeticamente
select * from Products
order by ProductName 

select * from Products
order by ProductName desc

--seleccionar todos los clientes por pais y dentro por nombre de forma ascendente

select country, CompanyName, city from Customers
order by country desc, CompanyName asc

--Operador and
--Seleccionar todos los clientes de espana y que su nombre comience con G
select ContactName, Country from Customers
where country = 'spain' and CompanyName like 'G%'

--Seleccionar todos los clientes de Berlin, alemania con codigo postal mayor 
select * from Customers
where Country = 'Germany' and
city = 'Berlin' and PostalCode > 1200;

--Seleccionar todos los clientes de espana y que su nombre comience con G o con R
select * from Customers
where Country = 'Spain' and (CompanyName like 'G%' or CompanyName like 'R%')

--Clausula or
--Seleccionar todos lops clientes de alemania o espana
select * from Customers
where country = 'Germany' or country = 'spain' 

--Seleccionar todos los clientes de berlin o de noruega o que comience su nombre con g
select * from Customers
where country = 'Norway' or city = 'Berlin' or CompanyName like 'G%'








