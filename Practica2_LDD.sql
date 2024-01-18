--Practica #2

--Crear nueva base de datos

CREATE DATABASE Practica2
go

USE Practica2
go

--Crear tabla cliente

CREATE TABLE tblCliente(
clienteid int not null,
nombre varchar (100) not null,
direccion varchar (100) not null,
tel varchar(20),
constraint pk_cliente
primary key (clienteid),
constraint unico_nombre
unique (nombre)
)
go

-- Crear tabla empleado 
CREATE TABLE tblempleado(
   idEmpleado int not null,
   nombre varchar(50) not null,
   apellidos varchar(50) not null,
   direccion varchar(100),
   sexo char(1) not null,
   salario decimal(10,2) not null,
   constraint pk_tblempleado
   primary key(idEmpleado),
   constraint chk_salario
  check(salario>=400 and salario<=50000),
)
go

--Crear tabla venta

create table tblVenta(
 idVenta int not null,  
 fecha date not null, 
 clienteid int not null,
 idempleado int not null,
  constraint pk_tblVenta
   primary key(idVenta),
  constraint fk_tblCliente
  foreign key(clienteid)
  references tblCliente(clienteid),
  constraint fk_tblempleado
  foreign key(idempleado)
  references tblempleado(idEmpleado)
)

CREATE TABLE tblProducto(
   idProducto int not null,
   descripcion varchar(200) not null,
   existencia int not null,
   precioUnitario decimal(10,2) not null, 
   constraint pk_tblproducto
   primary key (idProducto),
   constraint unique_descripcion
   unique(descripcion)
)
go

create table tblDetalle_venta(
  idVenta int not null,
  idProducto int not null,
  precio decimal(10,2) not null,
  cantidad int not null, 
  constraint pk_detalle_venta
  primary key(idVenta,idProducto),
  constraint fk_tblVenta
  foreign key(idVenta)
  references tblVenta(idVenta),
  constraint fk_tblproducto
  foreign key(idProducto)
  references tblproducto(idProducto),
)

