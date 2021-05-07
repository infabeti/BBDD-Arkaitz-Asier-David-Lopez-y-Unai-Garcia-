drop procedure if exists AlgoritmoNaiveBayes;
delimiter //
create procedure AlgoritmoNaiveBayes(codproducto1 int, codproducto2 int)
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
declare codAli int;
declare codAliSup int;
declare fec date;

select count(Transaccion) into contadortransacciones
from LineaProducto
where CodigoAlimento=codproducto1 and transaccion in 
(select Transaccion from LineaProducto
where CodigoAlimento=codproducto2);

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

if probabilidadproductototal is not null then

select CodigoAlimento, CodigoAlimentoSuperior, Fecha into codAli, codAliSup, fec from condiciona where Fecha = current_date();

if codAli = codproducto1 and codAliSup = codproducto2 and fec = current_date() then
update condiciona set Probabilidad = probabilidadproductototal
where CodigoAlimento=codproducto1 and CodigoAlimentoSuperior=codproducto2 and Fecha=current_date();
else
insert into fecha values (current_date());
insert into condiciona values (codproducto1, codproducto2, current_date(), probabilidadproductototal);
end if;
end if;
end//

call AlgoritmoNaiveBayes('1','2');

