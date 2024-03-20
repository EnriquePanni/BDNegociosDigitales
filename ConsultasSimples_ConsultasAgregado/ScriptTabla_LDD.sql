select * from Categoria

--Agregar una sola fila una tabla(Categoria)

insert into categoria
values (1,'Carnes Frias')

insert into categoria
values (1,'Lacteos')

insert into categoria
values (1,'Vinos y Licores')

insert into categoria
values (1,'Ropa')


insert into categoria (idCategoria, Descripcion)
values (5 'Linea Blanca'),

insert into categoria (Descripcion, idCategoria)
values (5 'Electronica', 6),

--Insert varios registros a la vez
insert into Categoria
values(7, 'Carnes Buenas'),
	(8,'Dulces'),
	(9,'Panaderia'),
	(10,'Salchichoneria'),

--Insertar a partir de una consulta

select id Categoria, Descripcion from categoria

create categoriaCopia(
	categoriaid int not null primary key,
	nombre varchar(100) not null
)


