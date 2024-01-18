-- SQL-LDD
-- Crear base de datos bdentornosvip

CREATE DATABASE bdentornosvip
go 

-- Cambiar de base de datos
USE bdentornosvip
go

--Crear la tabla categoria
CREATE Table tblcategoria(
	categoriaId int not null,
	descripcion varchar(100) not null,
	constraint pk_tblcategoria
	primary key(categoriaId),
	constraint unique_descripcion
	unique (descripcion)
)
go

--Crear tabla Productos

CREATE TABLE tblProducto(
  productoId int not null,
  nombreP varchar(50) not null,
  precio decimal(10,2) not null,
  existencia int not null,
  categoriaId int not null,
  constraint pk_tblProducto
  primary key(productoId),
  constraint unique_nombreP
  unique(nombreP),
  constraint chk_precio
  check(precio>0.0 and precio<=10000),
  constraint chk_existencia
  check(existencia>=0),
  constraint fk_tblProducto_tblcategoria
  foreign key(categoriaId)
  references tblcategoria(categoriaId)
)

-- Crear la Contacto y telefono

CREATE TABLE tblContacto (
    id_contacto INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
)

CREATE TABLE tblTelefono (
    id_telefono int not null,
    numero VARCHAR(15) NOT NULL,
    id_contacto int,
	constraint pk_tbltelefono
    primary key (id_telefono),
	constraint pk_tbltelefono_tblcontacto
    foreign key (id_contacto) 
	references tblContacto(id_contacto)
)