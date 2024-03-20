create or alter procedure llenar_tablas_catalogo
@nombreTabla varchar(100)
as
begin
    if @nombreTabla = 'clientes'
    begin
        insert into clientes
        select CustomerID,CompanyName,city, country
        from northwind.dbo.customers
    end
    else if @nombreTabla = 'productos'
    begin
        insert into productos
        select ProductID, ProductName,UnitsInStock, UnitPrice
        from northwind.dbo.Products
    end
    else if @nombreTabla = 'vendedor'
    begin
        insert into vendedor
        select EmployeeID, FirstName, LastName, city, country
        from northwind.dbo.Employees
    end
    else
    begin
       print('Nombre de tabla no valida')
    end
end

create trigger verificar_producto
on clientes
after insert
as
begin
   print('Se disparo el trigger de insert ')
end

create or alter trigger verificar_producto_eliminar
on clientes
after delete  
as
begin
   print('Se disparo el trigger de delete ')
end


create or alter trigger verificar_producto_eliminar
on clientes
after update  
as
begin
   print('Se disparo el trigger de update ')
end

create database pruebatriggers
go

use pruebatriggers

create table productos(
idproducto int not null,
nombreProd varchar(100) not null,
existencia int not null,
preciounitario decimal(10,2) not null,
constraint pk_idproducto
primary key (idproducto),
constraint unique_nombreprd
unique (nombreProd)
)
go


create table ventas (
ventaid int not null,
fecha date not null,
idcliente int not null,
idvendedor int not null,
constraint pk_ventas
primary key(ventaid)
)


create table clientes (
idcliente nchar(5) not null,
nombre varchar(100),
ciudad varchar(20),
pais varchar(20),
constraint pk_cliente
primary key(idcliente)
)



create table vendedor(
idvendedor int not null,
nombre varchar(100) not null,
apellidos varchar(50) not null,
ciudad varchar(20),
pais varchar(20),
constraint pk_vendedor
primary key(idvendedor)
)


create table detalle_venta
(
idventa int not null,
idproducto int not null,
precioVenta decimal(10,2),
cantidad int
constraint pk_detalle_venta
primary key(idventa),
constraint fk_detalle_venta_venta
foreign key (idventa)
references ventas(ventaid),
constraint fk_detalle_venta_producto
foreign key (idproducto)
references productos(idproducto)
)


alter table ventas
add constraint fk_venta_vendedor
foreign key (idvendedor)
references vendedor

create or alter procedure llenar_tablas_catalogo
@nombreTabla varchar(100)
as
begin
    if @nombreTabla = 'clientes'
    begin
        insert into clientes
        select CustomerID,CompanyName,city, country
        from northwind.dbo.customers
    end
    else if @nombreTabla = 'productos'
    begin
        insert into productos
        select ProductID, ProductName,UnitsInStock, UnitPrice
        from northwind.dbo.Products
    end
    else if @nombreTabla = 'vendedor'
    begin
        insert into vendedor
        select EmployeeID, FirstName, LastName, city, country
        from northwind.dbo.Employees
    end
    else
    begin
       print('Nombre de tabla no valida')
    end
end



select * from clientes
exec llenar_tablas_catalogo 'clientes'

select * from vendedor
exec llenar_tablas_catalogo 'vendedor'

select * from productos
exec llenar_tablas_catalogo 'productos'

create or alter procedure cargar_ventas
as
begin
insert into ventas
select orderid, OrderDate,CustomerID, EmployeeID
from northwind.dbo.Orders
end

select * from ventas
exec cargar_ventas

create or alter procedure cargar_detalle_venta
as
begin

  insert into detalle_venta
  select OrderID, ProductID,UnitPrice, Quantity
  from northwind.dbo.[Order Details]
end

select * from detalle_venta
exec cargar_detalle_venta


create trigger verificar_producto
on clientes
after insert
as
begin
   print('Se disparo el trigger de insert ')
end

create or alter trigger verificar_producto_eliminar
on clientes
after delete  
as
begin
   print('Se disparo el trigger de delete ')
end


create or alter trigger verificar_producto_eliminar
on clientes
after update  
as
begin
   print('Se disparo el trigger de update ')
end


select * from clientes

insert into clientes
values
('ABC10', 'Cliente nuevo', 'Santa Maria', 'Francia' )

delete from clientes
where idcliente = 'ABC10'

update clientes
set nombre = 'clientexx'
where idcliente = 'ABC10'


create or alter trigger verificar_cliente_eventos
on clientes
after insert, delete, update
as
begin
   if (select count(*) from inserted) > 0 and (select count(*) from deleted) = 0
   begin
       print 'se realizo un insert'
   end
   else if (select count(*) from inserted) = 0 and (select count(*) from deleted) > 0
   begin
   print 'se realizo un delete'
   end
   else if (select count(*) from inserted) > 0 and (select count(*) from deleted) > 0
    begin
     print 'se realizo un update'
   end
end

use pruebatriggers

create trigger agregarpreciodetalleventa
on detalle_venta
for insert
as
begin
	declare @idproducto int
	declare @precio decimal(10,2)
	set @idproducto = (select idproducto from inserted)
	set @precio = (select preciounitario from productos where idproducto = @idproducto)

	update detalle_venta 
	set precioVenta = @precio
	where idproducto = @idproducto

	end

select * from detalle_venta
insert into detalle_venta (idventa, idproducto, cantidad)
values('10250', 22, 4)

select preciunitario from prodcutos where idprodcuto = 22

select * from detalle_venta where idventa = '10250'

create proc AgregarPrecioDetalleVenta
    @idproducto int
as
begin
    declare @precio decimal(10,2)

    -- Get the price from the productos table based on idproducto
    select @precio = preciounitario
    from productos
    where idproducto = @idproducto

    -- Update the detalle_venta table with the calculated price
    update detalle_venta
    set precioVenta = @precio
    where idproducto = @idproducto
end

exec AgregarPrecioDetalleVenta @idproducto = 123

SELECT *
FROM detalle_venta
WHERE idproducto = 123;


update d 
set d.precioVenta = pr.preciounitario
@numVenta int, @numeroProd int, @cantidad int
as 
begin
insert into detalle_venta (idventa, idproducto, cantidad)
values (@numVenta, @numeroProd, @cantidad)
end

