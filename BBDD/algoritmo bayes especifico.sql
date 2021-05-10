drop procedure if exists AlgoritmoNaiveBayesEspecifico;
delimiter //
create procedure AlgoritmoNaiveBayesEspecifico(nifLocal char(9), codproducto1 int, codproducto2 int)
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
declare nifAli char(9);
declare codAli int;
declare codAliSup int;
declare fec date;

select count(Transaccion) into contadortransacciones
from lineaproducto
where CodigoAlimento=codproducto1 and transaccion in 
	(select LP.Transaccion from lineaproducto LP join actividad A on LP.Transaccion = A.Transaccion
	where CodigoAlimento=codproducto2 and A.NIF=nifLocal);

select count(transaccion) into contadorProducto1
from lineaproducto
where codproducto1=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date() and NIF=nifLocal);

select count(transaccion) into contadorProducto2
from lineaproducto
where codproducto2=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date() and NIF=nifLocal);

select count(Transaccion) into contadortransaccionestotales
from actividad
where NIF=nifLocal and fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date();

set probabilidadproductorelacion = contadortransacciones/contadorproducto1;

set probabilidadproducto1 = contadorproducto1/contadortransaccionestotales;

set probabilidadproducto2 = contadorproducto2/contadortransaccionestotales;

set probabilidadproductototal = (probabilidadproductorelacion*probabilidadproducto1)/probabilidadproducto2;

if probabilidadproductototal is not null then

	select NIF, CodigoAlimento, CodigoAlimento2, Fecha into nifAli, codAli, codAliSup, fec from secombinacon
    where NIF = nifLocal and CodigoAlimento = codproducto1 and CodigoAlimento2 = codproducto2 and Fecha = current_date();

	if nifAli = nifLocal and codAli = codproducto1 and codAliSup = codproducto2 and fec = current_date() then
		update secombinacon set Probabilidad = probabilidadproductototal
		where NIF = nifLocal and CodigoAlimento=codproducto1 and CodigoAlimento2=codproducto2 and Fecha=current_date();
		else
		if fec != current_date() then
			insert into fecha values (current_date());
		end if;
		insert into secombinacon values (nifLocal, codproducto1, codproducto2, current_date(), probabilidadproductototal);
	end if;
end if;
end//