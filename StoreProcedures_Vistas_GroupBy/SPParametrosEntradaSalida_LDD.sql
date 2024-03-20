--sp con parametros de salida
use NORTHWND

create or alter proc sumadediez
	@valor int = 10
	as

declare @resultado int = 0
set @resultado = @valor + 10
print ('El resultado es: ' + cast (@resultado as varchar (10)))

exec sumadediez
exec sumadediez @valor = 30

--sp2
create or alter proc sumadediez2
@valor int, @resultado int output
as
	set @resultado = @valor + 10

declare @result int 
exec sumadediez2 @valor = 50, @resultado = @result output
print ('El resultado es: ' + cast (@result as varchar (10)))

--Sp que haga suma y resta con parametros de salida
create procedure SumaResta
    @numero1 int,
    @numero2 int,
    @suma int output,
    @resta int output
as
    set @suma = @numero1 + @numero2;
    set @resta = @numero1 - @numero2;

declare @resultadoSuma int;
declare @resultadoResta int;
exec SumaResta @numero1 = 10, @numero2 = 5, @suma = @resultadoSuma output, @resta = @resultadoResta output;
print 'El resultado de la suma es: ' + cast(@resultadoSuma as varchar(10))
print 'El resultado de la resta es: ' + cast(@resultadoResta as varchar(10))