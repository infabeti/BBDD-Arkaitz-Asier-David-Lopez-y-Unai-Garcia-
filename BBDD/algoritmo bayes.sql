drop procedure if exists AlgoritmoNaiveBayes;
delimiter //
create procedure AlgoritmoNaiveBayes(PrimerProducto varchar(40),SegundoProducto varchar(40))

begin

declare fechatransaccion date;
declare contadortransacciones int;
declare contadortransaccionestotales int;
declare contadortransaccion1 int;
declare contadortransaccion2 int;
declare resultado float;
declare contadorProducto1 int;
declare contadorProducto2 int;
declare probabilidadproductorelacion float;
declare probabilidadproducto1 float;
declare probabilidadproducto2 float;
declare probabilidadproductototal float;
declare codproducto1 int;
declare codproducto2 int;

select distinct CodigoAlimento into codproducto1
from LineaProducto 
where Codigoalimento=(select Codigoalimento
						from alimento
						where nombre=PrimerProducto);


select distinct CodigoAlimento into codproducto2
from LineaProducto 
where Codigoalimento=(select Codigoalimento
						from alimento
					  where nombre=SegundoProducto);

select count(Transaccion) into contadortransacciones
from LineaProducto
where CodigoAlimento=codproducto1 and transaccion in 
(select Transaccion 
from LineaProducto
where CodigoAlimento=codproducto2);

/*Funciona hasta aquí*/

select count(transaccion) into contadorProducto1
from LineaProducto
where codproducto1=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date());

select count(transaccion) into contadorProducto2
from LineaProducto
where codproducto2=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date());

select count(Transaccion) into contadortransaccionestotales
from actividad
where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date();

set probabilidadproductorelacion = contadortransacciones/contadorproducto1;

set probabilidadproducto1 = contadorproducto1/contadortransaccionestotales;

set probabilidadproducto2 = contadorproducto2/contadortransaccionestotales;

set probabilidadproductototal = (probabilidadproductorelacion*probabilidadproducto1)/probabilidadproducto2;

select concat('Coinciden ',contadortransacciones,' veces, el primer producto se ha comprado ',contadorProducto1,' veces y el segundo producto ',contadorProducto2,' veces.
La probabilidad conjunta es ',probabilidadproductorelacion,', la probabilidad del primer producto ',probabilidadproducto1,', probabilidad del segundo producto ',probabilidadproducto2,'
 y la probabilidad de que coincidan es de ',probabilidadproductototal) Resultado;

end//

call AlgoritmoNaiveBayes("Aquarius","Coca-cola");
call AlgoritmoNaiveBayes("Aquarius","Aquarius");

