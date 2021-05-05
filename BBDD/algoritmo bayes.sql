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
				where fecha between current_date() and (DATE_SUB(current_date(),INTERVAL 6 DAY)));

select count(transaccion) into contadorProducto2
from LineaProducto
where codproducto2=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between current_date() and (DATE_SUB(current_date(),INTERVAL 6 DAY)));

select count(transaccion) into contadortransaccionestotales
from actividad
where fecha between current_date() and (DATE_SUB(current_date(),INTERVAL 6 DAY));
select concat(contadortransaccionestotales) Resultado1;

set probabilidadproductorelacion = contadorproducto2/contadorproducto1;

set probabilidadproducto1 = contadorproducto1/contadortransaccionestotales;

set probabilidadproducto2 = contadorproducto2/contadortransaccionestotales;

set probabilidadproductototal = (probabilidadproductorelacion*probabilidadproducto1)/probabilidadproducto2;

select concat('Coinciden ',contadortransacciones,' veces, el primer producto se ha comprado ',contadorProducto1,' veces y el segundo producto ',contadorProducto2,' veces.
La probabilidad conjunta es ',probabilidadproductorelacion,', la probabilidad del primer producto ',probabilidadproducto1,', probabilidad del segundo producto ',probabilidadproducto2,' y la probabilidad de que coincidan es de ',probabilidadproductototal) Resultado;

/*
select count(transacciones) into contadortransaccionestotales
from actividades
where fecha = current_date();


select (contadorproducto1/contadortransaccionestotales) into probabilidadproducto1; 

select (contadorproducto2/contadortransaccionestotales) into probabilidadproducto2; 

select (probabilidadproducto1/probabilidadproducto2)/resultado into probabilidadproductototal; 



if contadortransacciones > 1 then

select resultado = contadortransaccionestotales((contadorProducto1*contadortransacciones)/contadorProducto2);

		select concat("De las ",contadortransaccionestotales," compras realizadas en ",contadortransacciones,"se han comprado ",PrimerProducto," y ",SegundoProducto);
        
        select concat("De las ",contadorProducto1," que se han comprado ",PrimerProducto,"en un total de ",probabilidadproducto1);
        
		select concat("De las ",contadorProducto2," que se han comprado ",SegundoProducto,"en un total de ",probabilidadproducto2);
        
        select concat("Por lo tanto la probabilidad de comprar ",PrimerProducto," sera de ",probabilidadproductototal);
        
        
else 

		select	concat("No se han realizado coincidencias entre los dos productos");
        
 end if;       
*/
end//

call AlgoritmoNaiveBayes("Aquarius","Coca-cola");

