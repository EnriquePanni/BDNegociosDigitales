select * from 
clientes as c 
inner join ordenes as o
on c.numero = o.clienteid

--inner join
select c.numero as 'Numero del Cliente',
c.nombre as 'Nombre del cliente',
o.FechaOrden as 'Fecha de la orden',
o.FechaEntrega as 'Fecha de entrega',
o.clienteid as 'Foreing key de la tabla cliente'
from 
clientes as c 
inner join ordenes as o
on c.numero = o.clienteid

--left join (la tabla izquierda siempre es la primera
--que se pone en el join)

select c.numero as 'Numero del Cliente',
c.nombre as 'Nombre del cliente',
o.FechaOrden as 'Fecha de la orden',
o.FechaEntrega as 'Fecha de entrega',
o.clienteid as 'Foreing key de la tabla cliente'
from 
clientes as c 
left join ordenes as o
on c.numero = o.clienteid

--Todos aquellos clientes que no han hecho ordenes con inner 
select c.numero as 'Numero del Cliente',
c.nombre as 'Nombre del cliente',
o.FechaOrden as 'Fecha de la orden',
o.FechaEntrega as 'Fecha de entrega',
o.clienteid as 'Foreing key de la tabla cliente'
from 
clientes as c 
left join ordenes as o
on c.numero = o.clienteid
where o.clienteid is null

--Seleccionar todos los datos de la tabla ordenes 
--y la tabla clientes utilizando un left join
select c.numero as 'Numero del Cliente',
c.nombre as 'Nombre del cliente',
o.FechaOrden as 'Fecha de la orden',
o.FechaEntrega as 'Fecha de entrega',
o.clienteid as 'Foreing key de la tabla cliente'
from 
ordenes as o
left join clientes as c
on o.clienteid = c.numero

--right join
select c.numero as 'Numero del Cliente',
c.nombre as 'Nombre del cliente',
o.FechaOrden as 'Fecha de la orden',
o.FechaEntrega as 'Fecha de entrega',
o.clienteid as 'Foreing key de la tabla cliente'
from 
ordenes as o
right join clientes as c
on c.numero = o.clienteid

--fulljoin
select c.numero as 'Numero del Cliente',
c.nombre as 'Nombre del cliente',
o.FechaOrden as 'Fecha de la orden',
o.FechaEntrega as 'Fecha de entrega',
o.clienteid as 'Foreing key de la tabla cliente'
from 
ordenes as o
full join clientes as c
on c.numero = o.clienteid


select o.numero, nombre, pais fechaOrden from ordenes as o
full join (select numero,nombre,pais from Clientes) as c
on o.clienteid = c.numero 