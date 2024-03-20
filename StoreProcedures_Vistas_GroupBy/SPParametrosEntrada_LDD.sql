use NORTHWND

--Realizar un sp para Calcular el Total de una orden
create procedure spCalcularTotalOrden
    @OrderID int
as
begin
    select 
        o.OrderID,
        Sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalOrden
    from Orders as o
    inner join [Order Details] as od on o.OrderID = od.OrderID
    where o.OrderID = @OrderID
    group by o.OrderID
end
go

drop proc spCalcularTotalOrden
go

exec spCalcularTotalOrden @OrderID = 10249

--Realizar un sp para Actualizar la Cantidad de Productos en Stock
create procedure spActualizarCantidadStock
    @ProductID int,
    @NuevaCantidadEnStock int
as
begin
update Products
Set UnitsInStock = @NuevaCantidadEnStock 
where ProductID = @ProductID
end
go

drop proc spActualizarCantidadStock
go

exec spActualizarCantidadStock @ProductID = 1, @NuevaCantidadEnStock = 50

--Realizar un SP para Calcular el Total de Ventas de un Empleado
create procedure spCalcularTotalVentasEmpleado
    @EmployeeID int
as
begin
select
e.EmployeeID,
e.FirstName + ' ' + e.LastName as 'Nombre del Empleado',
sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as 'TotalVentas'
from Employees as e
inner join Orders as o on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od on o.OrderID = od.OrderID
where e.EmployeeID = @EmployeeID
group by e.EmployeeID, e.FirstName, e.LastName
order by e.EmployeeID;
end

drop proc spCalcularTotalVentasEmpleado
go

exec spCalcularTotalVentasEmpleado @EmployeeID = 1

--Realizar un SP para Actualizar el Nombre de un Empleado
create procedure spActualizarNombreEmpleado
    @EmployeeID INT,
    @NuevoNombreEmpleado char(50)
as
begin
update Employees
Set FirstName = @NuevoNombreEmpleado
where EmployeeID = @EmployeeID
end
go

drop proc spActualizarNombreEmpleado
go

exec spActualizarNombreEmpleado @EmployeeID = 1, @NuevoNombreEmpleado = Juanito

--Realizar un SP para Obtener el Total de Ventas por País
create proc spTotalVentasPorPais
as
begin
select 
c.Country AS 'País',
sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'TotalVentas'
from Orders as o
inner join Customers AS c ON o.CustomerID = c.CustomerID
inner join [Order Details] AS od ON o.OrderID = od.OrderID
group by c.Country
order by 'TotalVentas' DESC;
end
go

exec spTotalVentasPorPais;

--Realizar un SP para Obtener el Número de Órdenes por Cliente
create proc spNumeroOrdenesPorCliente
as
begin
select 
c.CustomerID,
c.CompanyName as 'NombreCliente',
count(o.OrderID) as 'NumeroOrdenes'
from Customers as c
left join Orders AS o ON c.CustomerID = o.CustomerID
group by c.CustomerID, c.CompanyName
order by 'NumeroOrdenes' DESC;
end

exec spNumeroOrdenesPorCliente;

--Realizar un SP para Calcular el Total de Productos Vendidos por Categoría
create procedure spTotalProductosVendidosPorCategoria
as
begin
select 
c.CategoryName as 'NombreCategoria',
p.ProductName as 'NombreProducto',
SUM(od.Quantity) as 'TotalVendido'
from Categories as c
inner join Products as p on c.CategoryID = p.CategoryID
inner join [Order Details] as od on p.ProductID = od.ProductID
group by c.CategoryName, p.ProductName
order by 'TotalVendido' desc
end

exec spTotalProductosVendidosPorCategoria

--SP para Calcular el Total de Ventas por Año
create proc spTotalVentasPorAño
as
begin
select 
year(o.OrderDate) AS 'Año',
sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'TotalVentas'
from Orders as o
inner join [Order Details] as od on o.OrderID = od.OrderID
group by year(o.OrderDate)
order by 'Año'
end

exec spTotalVentasPorAño

use NORTHWND

--Crear un sp que permita insertar registros en la tabla custumers
create proc spInsertarCliente
    @CompanyName CHAR(40),
    @Country CHAR(15),
    @City CHAR(15)
	as
	begin
	insert into Customers (CompanyName, Country, City)
	values (@CompanyName, @Country, @City)
	end

exec spInsertarCliente @Country = 'Germany', @city = 'Berlin', @CompanyName = 'Barrariabeer'

select *
from Customers
where Country = 'Germany'
and City = 'Berlin' 
and CompanyName = 'Barrariabeer'

--Crear un sp que permita eliminar registros en la tabla customers, por customerid
create proc spEliminarClientePorID
    @CustomerID char(15)
	as
	begin
    delete from Customers
    where CustomerID = @CustomerID;
end

exec spEliminarClientePorID @CustomerID = '1'

select *
from Customers
where CustomerID = '1'

--Crear un sp que permita eliminar un producto de una orden dada

create proc spEliminarProductoDeOrden
    @OrderID int,
    @ProductID int
as
begin
delete from [Order Details]
where OrderID = @OrderID and ProductID = @ProductID
end

exec spEliminarProductoDeOrden @OrderID = 10248, @ProductID = 11

select *
from [Order Details]
where OrderID = 10248 and ProductID = 11;

--Crear un sp que permita eliminar un producto de una orden y modificar el stock (unitstock del producto)

create proc spEliminarProductoyModificarStock
    @OrderID int,
    @ProductID int
	as
	begin
    declare @Cantidad int, @Precio money
    select @Cantidad = Quantity, @Precio = UnitPrice
    from [Order Details]
    where OrderID = @OrderID and ProductID = @ProductID
    update Products
    set UnitsInStock = UnitsInStock + @Cantidad
    where ProductID = @ProductID
    delete from [Order Details]
    where OrderID = @OrderID and ProductID = @ProductID
	end

exec spEliminarProductoyModificarStock @OrderID = 10248, @ProductID = 11

select *
from [Order Details]
where OrderID = 10248 and ProductID = 11;


select ProductID, ProductName, UnitsInStock
from Products
where ProductID = 11;

