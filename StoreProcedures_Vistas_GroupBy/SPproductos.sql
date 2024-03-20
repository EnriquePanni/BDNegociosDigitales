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
idcliente int not null,
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
add constraint fk_venta_cliente
foreign key (idcliente)
references clientes

alter table ventas
add constraint fk_venta_vendedor
foreign key (idvendedor)
references vendedor

create or alter procedure llenar_tablas_catalogo
@nombreTabla varchar(100)
as
begin
    if @nombreTabla = 'Clientes'
    begin
        insert into clientes
        select CustomerID,CompanyName,city, country
        from northwind.dbo.customers
    end
end
