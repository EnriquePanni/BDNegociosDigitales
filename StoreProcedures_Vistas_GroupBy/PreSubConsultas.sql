use NORTHWND

--Sintaxis
/*
	Case
	When condicional then resultado1
	When condicional then resultado1
	When condicional then resultado1
	When condicional then resultado1
	Else result
	end;
*/

select *,
	CASE 
		WHEN Quantity > 30 THEN 'La cantidad es mayor a 30'
		WHEN Quantity = 30 THEN 'La cantidad es 30'
		ELSE 'La cantidad esta por debajo de 30'
		END AS CantidadTexto
from [Order Details]


select *,
	case
		when UnitsInStock = 0 then 'Sin stock'
		when UnitsInStock between 1 and 20 then 'stock bajo'
		when UnitsInStock between 21 and 50 then 'stock medio'
		when UnitsInStock >= 51 and UnitsInStock <= 90 then 'Stock alto'
		else 'stock maximo'
		end as 'Tipo stock'
from Products

create database pruebacase

use pruebacase

create table nuevatabla(
	id int not null,
	nombre nvarchar(40) not null,
	unitprice money,
	unitsinstock smallint,
	constraint pk_nuevatabla
	primary key(id)
)

--Crear la esturctura de una tabla en base a una consulta
 
select top 0 ProductID as numeroproducto,
ProductName as descripcion, UnitPrice as preciounitario,
UnitsInStock as existencia
into nuevatabla2
from NORTHWND.dbo.Products

select * from nuevatabla2

alter table nuevatabla2 
add constraint pk_nuevatabla2
primary key(numeroproducto)

select ProductID as numeroproducto,
ProductName as descripcion, UnitPrice as preciounitario,
UnitsInStock as existencia
into nuevatabla3
from NORTHWND.dbo.Products

select * from nuevatabla3

select p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock,
	case
		when UnitsInStock = 0 then 'Sin stock'
		when UnitsInStock between 1 and 20 then 'stock bajo'
		when UnitsInStock between 21 and 50 then 'stock medio'
		when UnitsInStock >= 51 and UnitsInStock <= 90 then 'Stock alto'
		else 'stock maximo'
		end as 'Tipo stock'
		into tablaconcase
from NORTHWND.dbo.Products as p

-- PROCEDIMIENTOS ALMACENADOS

use NORTHWND
go

--SP para visualizar los clientes
create proc visualizarClientes
as
begin
select * from Customers
end
go

Alter create proc visualizarClientes
as
select * from Customers
end
go

--Eliminar sp
drop proc visualizarClientes
go

--Ejecutar sp
exec visualizarClientes
execute visualizarClientes
go

create proc listarclientesporciudad
@ciudad nvarchar(40)
as 
begin
select * from Customers
where CompanyName like concat 
end
go

exec listarclientesporciudad 'London'

--Realizar un sp que contenga las ventas totales
--Realizadas a los clientes por año elegido
-- Crear el procedimiento almacenado si no existe
IF OBJECT_ID('spVentasTotalesPorAnio', 'P') IS NOT NULL
    DROP PROCEDURE spVentasTotalesPorAnio;
go

CREATE PROCEDURE spVentasTotalesPorAnio
    @Anio int
as
begin
    SET NOCOUNT ON;
    select 
        YEAR(o.OrderDate) as 'Año', 
        c.CompanyName as 'Nombre del Cliente', 
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'Ventas Totales'
    from Orders as o
    INNER JOIN [Order Details] AS od ON o.OrderID = od.OrderID
    INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
    where YEAR(o.OrderDate) = @Anio
    group by YEAR(o.OrderDate), c.CompanyName
    order by c.CompanyName;
end;
go

EXEC spVentasTotalesPorAnio @Anio = 1997