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




