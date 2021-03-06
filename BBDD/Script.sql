create database reto3 collate utf8mb4_spanish_ci;

use reto3;

/*Local cambiado por establecimiento porque local es una palabra reservada en SQL*/

create table establecimiento(
NIF char(9) primary key,
Nombre varchar(40) not null,
Direccion varchar(40) not null,
TipoNegocio enum ('BAR', 'CAFETERIA', 'RESTAURANTE') not null
);


create table empleado(
DNI char(9) primary key,
Nombre varchar(20) not null,
Apellido varchar(25) not null,
contrasena varchar(18) not null,
NIF char(9) not null,
constraint fk_NIF_empleado foreign key (NIF) references establecimiento (NIF) on update cascade
);

create table actividad(
Transaccion int primary key,
Fecha date not null,
TotalOperacion float not null,
tipo enum ('TICKET', 'FACTURA', 'COMANDA', 'PEDIDO', 'APROVISIONAMIENTO') not null,
NIF char(9) not null,
constraint fk_NIF_actividad foreign key (NIF) references establecimiento (NIF) on update cascade
);

create table alimento(
CodigoAlimento int primary key,
Nombre varchar(40) not null,
Tipo enum ('BEBIDA', 'COMIDA', 'OTROS')  not null,
FeCad date,
PCompra float not null default false,
vegetariano boolean not null  default false,
marisco boolean not null default false,
vegano boolean not null default false,
gluten boolean not null default false,
FrutosSecos boolean not null default false
);

create table fecha(
Fecha date primary key
);

create table stock(
NIF char(9) not null,
CodigoAlimento int not null,
cantidad int not null,
constraint pk_stock primary key (NIF, CodigoAlimento),
constraint fk_NIF_stock foreign key (NIF) references establecimiento (NIF) on update cascade,
constraint fk_NIF_CodigoAlimento foreign key (CodigoAlimento) references alimento(CodigoAlimento) on update cascade
);

create table SeCombinaCon(
NIF char(9) not null,
CodigoAlimento int not null,
CodigoAlimento2 int not null,
Fecha date not null,
Probabilidad float,
constraint pk_SeCombinaCon primary key (NIF, CodigoAlimento, CodigoAlimento2, Fecha),
constraint fk_SeCombinaCon_NIF_CodigoAlimento foreign key (NIF,CodigoAlimento) references stock(NIF,CodigoAlimento) on update cascade,
constraint fk_SeCombinaCon_fecha foreign key (Fecha) references fecha(Fecha) on update cascade,
constraint fk_SeCombinaCon_CodigoAlimento2 foreign key (NIF, CodigoAlimento2) references stock(NIF,CodigoAlimento) on update cascade
);

create table condiciona(
CodigoAlimento int not null,
CodigoAlimentoSuperior int not null,
Fecha date not null,
Probabilidad float not null,
constraint pk_condiciona primary key (CodigoAlimento, CodigoAlimentoSuperior, Fecha),
constraint fk_stock_fecha foreign key (Fecha) references fecha(Fecha) on update cascade,
constraint fk_condiciona_CodigoAlimento foreign key (CodigoAlimento) references alimento(CodigoAlimento) on update cascade,
constraint fk_condiciona_CodigoAlimentoSuperior foreign key (CodigoAlimentoSuperior) references alimento(CodigoAlimento) on update cascade
);

create table producto(
CodigoAlimento int primary key,
PVenta float not null,
constraint fk_producto_codigoAlimento foreign key (CodigoAlimento) references alimento (CodigoAlimento) on update cascade
);

create table ingrediente(
CodigoAlimento int primary key,
constraint fk_ingrediente_codigoAlimento foreign key (CodigoAlimento) references alimento (CodigoAlimento) on update cascade
);

create table lineaproducto(
CodigoAlimento int,
Transaccion int,
Cantidad int not null,
PrecioFinal float not null,
TotalProducto float AS (Cantidad * PrecioFinal), /*Atributo calculado*/
constraint pk_lineaproducto primary key (Transaccion, CodigoAlimento),
constraint fk_lineaproducto_codigoAlimento foreign key (CodigoAlimento) references producto (CodigoAlimento) on update cascade,
constraint fk_lineaproducto_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);

create table composicion(
CodigoAlimentoProducto int,
CodigoAlimentoIngrediente int,
cantidad int,
constraint pk_composicion primary key (CodigoAlimentoProducto, CodigoAlimentoIngrediente),
constraint fk_composicion_CodigoAlimentoProducto foreign key (CodigoAlimentoProducto) references producto (CodigoAlimento) on update cascade,
constraint fk_composicion_CodigoAlimentoIngredienteo foreign key (CodigoAlimentoIngrediente) references ingrediente (CodigoAlimento) on update cascade
);

create table comprador(
NIF char(9) primary key,
Nombre varchar(20) not null,
Apellido varchar(25) not null
);

create table factura(
Transaccion int primary key,
NIF char(9) not null,
constraint fk_factura_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade,
constraint fk_factura_nif foreign key (NIF) references comprador (NIF) on update cascade
);

create table pedido(
Transaccion int primary key,
domicilio varchar(60),
constraint fk_pedido_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);

create table fabricante(
CodFabr int primary key,
Nombre varchar(40) not null,
TiempoEntrega int not null
);

create table aprovisionamiento(
Transaccion int primary key,
CodFabr int not null,
constraint fk_aprovisionamiento_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);


create table comanda(
Transaccion int primary key,
constraint fk_comanda_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);

create table plato(
codigoplato int primary key,
Nombre varchar(80) not null,
pvp float not null
);

create table lineaplato(
codigoplato int,
Transaccion int,
cantidad int not null,
constraint ch_cantidad check(cantidad>0),
constraint pk_lineaplato primary key (codigoplato, Transaccion),
constraint fk_lineaplato_codigoplato foreign key (codigoplato) references plato (codigoplato) on update cascade,
constraint fk_lineaplato_transaccion foreign key (Transaccion) references comanda (Transaccion) on update cascade
);

create table lineaingrediente(
codigoplato int,
CodigoAlimento int,
cantidad int,
constraint pk_lineaingrediente primary key (codigoplato, CodigoAlimento),
constraint fk_lineaingrediente_codigoplato foreign key (codigoplato) references plato (codigoplato) on update cascade,
constraint fk_lineaingrediente_CodigoAlimento foreign key (CodigoAlimento) references ingrediente (CodigoAlimento) on update cascade
);

create table suministro(
Transaccion int,
CodigoAlimento int,
constraint pk_suministro primary key (Transaccion, CodigoAlimento),
constraint fk_suministro_CodigoAlimento foreign key (CodigoAlimento) references ingrediente (CodigoAlimento) on update cascade,
constraint fk_suministro_transaccion foreign key (Transaccion) references aprovisionamiento (Transaccion) on update cascade
);

create table carta(
NIF char(9),
codigoplato int,
constraint fk_carta_nif foreign key (nif) references establecimiento(nif) on update cascade,
constraint fk_carta_codigoplato foreign key (codigoplato) references plato(codigoplato) on update cascade
);


/* Inserciones establecimientos */

insert into establecimiento
values ('12345678H', 'Bar Buenavista', 'Calle buenavista 7', 'Bar') ;

insert into establecimiento
values ('23456789J', 'Ristorante Fuggini', 'Gran V??a 3', 'Restaurante') ;

insert into establecimiento
values ('34567899K', 'Caf?? Manolo', 'Montevideo 4', 'Cafeteria') ;

/* Inserciones empleados */

insert into empleado
values ('12312122S', 'Jon', 'Zampon','Zampon', '12345678H') ;

insert into empleado
values ('75623142C', 'Kevin', 'Monasterio','12345', '23456789J') ;

insert into empleado
values ('85296365L', 'Maria', 'Zambrano','maria123', '34567899K') ;

/* Inserciones Alimentos y productos */

insert into alimento 
values(1, 'Aquarius', 'Bebida', '2021/02/20', '0.35', true,true,true,true,true);

insert into producto
values(1, 2.00);

insert into alimento 
values(2, 'Coca-cola', 'Bebida', '2021/02/20', '0.35', true,true,true,true,true);

insert into producto
values(2, 1.80);

insert into alimento 
values(3, 'Bocata de tortilla', 'Comida', '2021/02/20', '1.00', true,true,false,false,true);

insert into producto
values(3, 2);

insert into alimento 
values(4, 'Ca??a Cerveza Rubia', 'Bebida', '2021/11/20', '0.25', true,true,true,false,true);

insert into producto
values(4, 2.20);

insert into alimento 
values(5, 'Zurito Rubio', 'Bebida', '2021/11/20', '0.15', true,true,true,false,true);

insert into producto
values(5, 1);

insert into alimento 
values(6, 'Cerveza Radler', 'Bebida', '2021/11/20', '0.35', true,true,true,false,true);

insert into producto
values(6, 2.20);

insert into alimento 
values(7, 'Mojito', 'Bebida', '2021/11/20', '2.00', true,true,true,true,true);

insert into producto
values(7, 6);

insert into alimento 
values(8, 'Cubata', 'Bebida', '2021/11/20', '2.00', true,true,true,true,true);

insert into producto
values(8, 6);

insert into alimento 
values(9, 'Sandwich Jam??n y Queso', 'Comida', '2021/03/20', '0.70', false,true,false,true,true);

insert into producto
values(9, 1.60);

insert into alimento 
values(10, 'Patatas Lays', 'Comida', '2021/12/20', '0.30', true,true,true,true,true);

insert into producto
values(10, 2);

insert into alimento 
values(11, 'Caf?? Solo', 'Bebida', '2021/12/20', '0.15', true,true,true,true,true);

insert into producto
values(11, 1.10);

insert into alimento 
values(12, 'Caf?? con leche', 'Bebida', '2021/12/20', '0.25', true,true,false,true,true);

insert into producto
values(12, 1.20);

insert into alimento 
values(13, 'Cola Cao', 'Bebida', '2022/12/20', '0.30', true,true,true,true,true);

insert into producto
values(13, 2);

/* Stock de establecimiento */

insert into stock
values('12345678H', 1, 20);

insert into stock
values('12345678H', 2, 20);

insert into stock
values('12345678H', 3, 20);

insert into stock
values('12345678H', 4, 100);

insert into stock
values('12345678H', 5, 400);

insert into stock
values('12345678H', 6, 100);

insert into stock
values('12345678H', 7, 58);

insert into stock
values('12345678H', 8, 69);

insert into stock
values('12345678H', 11, 90);

insert into stock
values('12345678H', 12, 150);

insert into stock
values('12345678H', 10, 14);

insert into stock
values('34567899K', 1, 20);

insert into stock
values('34567899K', 2, 20);

insert into stock
values('34567899K', 3, 20);

insert into stock
values('34567899K', 4, 100);

insert into stock
values('34567899K', 5, 400);

insert into stock
values('34567899K', 6, 100);

insert into stock
values('34567899K', 7, 58);

insert into stock
values('34567899K', 8, 69);

insert into stock
values('34567899K', 11, 90);

insert into stock
values('34567899K', 12, 150);

insert into stock
values('34567899K', 10, 14);

insert into stock
values('23456789J', 1, 20);

insert into stock
values('23456789J', 2, 20);

insert into stock
values('23456789J', 3, 20);

insert into stock
values('23456789J', 4, 100);

insert into stock
values('23456789J', 5, 400);

insert into stock
values('23456789J', 6, 100);

insert into stock
values('23456789J', 7, 58);

insert into stock
values('23456789J', 8, 69);

insert into stock
values('23456789J', 11, 90);

insert into stock
values('23456789J', 12, 150);

insert into stock
values('23456789J', 10, 14);


/* INSERCIONES PLATOS */
insert into plato
values (1,'Espaguetis a la carbonara', 11.99);

insert into plato
values (2,'Risoto de setas y hongos', 12.95);

insert into plato
values (3,'Ensalada mixta', 8.99);

insert into plato
values (4,'Ensaladilla rusa', 9.99);

insert into plato
values (5,'Milanesa de ternera con queso', 11.99);

insert into plato
values (6,'Pimientos rellenos de bacalao', 9.99);

insert into plato
values (7,'Filete de ternera con patatas', 15.99);

insert into plato
values (8,'Entrecot con pimientos y patatas', 15.99);

insert into plato
values (9,'Brownie con helado ', 7.99);

insert into plato
values (10,'Tarta de queso', 5.99);

insert into plato
values (11,'Tarta tres chocolates', 6.99);

/*Inserciones en la carta*/

insert into carta
values ('23456789J', 1);

insert into carta
values ('23456789J', 2);

insert into carta
values ('23456789J', 3);

insert into carta
values ('23456789J', 4);

insert into carta
values ('23456789J', 5);

insert into carta
values ('23456789J', 6);

insert into carta
values ('23456789J', 7);

insert into carta
values ('23456789J', 8);

insert into carta
values ('23456789J', 9);

insert into carta
values ('23456789J', 10);

insert into carta
values ('23456789J', 11);

/*TRIGGERS*/

 delimiter &&
create trigger actualizar1_stock
after insert on lineaproducto 
for each row

begin
	if(select tipo 
    from actividad 
		where Transaccion = New.Transaccion)='APROVISIONAMIENTO'
then
	update stock 
    set cantidad = cantidad + new.Cantidad
		where NIF = (select NIF 
    from actividad 
		where Transaccion = new.Transaccion) and CodigoAlimento = new.CodigoAlimento;
else 
	update stock 
    set cantidad = cantidad - new.Cantidad
		where NIF = (select NIF 
    from actividad 
		where Transaccion = new.Transaccion) and CodigoAlimento = new.CodigoAlimento;
end if;
end; &&

/*PROCEDIMIENTO*/

delimiter //
create procedure PrecioTotalPedido (TransaccionRecibida int)
reads sql data

begin
	declare PrecioTotalProducto float;
	declare PrecioTotalPlato float;
	declare CodigoDelPlato int;
	declare PVP float;
	declare Cantidad int;
	declare TipoObtenido enum('TICKET','FACTURA','COMANDA','PEDIDO','APROVISIONAMIENTO');

	select tipo into TipoObtenido from actividad where Transaccion = TransaccionRecibida;

	select sum(TotalProducto) into PrecioTotalProducto from lineaproducto where Transaccion = TransaccionRecibida;

	if TipoObtenido = 'TICKET' or TipoObtenido = 'FACTURA' or TipoObtenido ='PEDIDO' or TipoObtenido ='APROVISIONAMIENTO' then
		update actividad set TotalOperacion= round(PrecioTotalProducto,2) where Transaccion = TransaccionRecibida;

	else
		select sum(P.pvp*L.cantidad) into PrecioTotalPlato from lineaplato L join plato P on L.codigoplato = P.codigoplato where Transaccion = TransaccionRecibida;
		update actividad set TotalOperacion = round(PrecioTotalProducto + PrecioTotalPlato,2) where Transaccion = TransaccionRecibida;

	end if;

end;//

create procedure AlgoritmoNaiveBayes(codproducto1 int, codproducto2 int)
begin

declare fechatransaccion date;
declare contadortransacciones int;
declare resultado float;
declare contadorProducto2 int;
declare probabilidadproductototal float;
declare codAli int;
declare codAliSup int;
declare fec date;

select count(Transaccion) into contadortransacciones
from lineaproducto
where CodigoAlimento=codproducto1 and transaccion in 
(select Transaccion from lineaproducto
where CodigoAlimento=codproducto2 and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date()));

select count(transaccion) into contadorProducto2
from lineaproducto
where codproducto2=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date());

set probabilidadproductototal = round(contadortransacciones/contadorproducto2,2);

if probabilidadproductototal is not null and probabilidadproductototal !=0 then

	select CodigoAlimento, CodigoAlimentoSuperior into codAli, codAliSup from condiciona
    where CodigoAlimento = codproducto1 and CodigoAlimentoSuperior = codproducto2 and Fecha = current_date();
    
	select Fecha into fec from Fecha
    where Fecha = current_date();

	if codAli = codproducto1 and codAliSup = codproducto2 and fec = current_date() then
		update condiciona set Probabilidad = probabilidadproductototal
		where CodigoAlimento=codproducto1 and CodigoAlimentoSuperior=codproducto2 and Fecha=current_date();
	else
		if fec is null then
			insert into fecha values (current_date());
		end if;
		insert into condiciona values (codproducto1, codproducto2, current_date(), probabilidadproductototal);
	end if;
end if;
end//

create procedure AlgoritmoNaiveBayesEspecifico(nifLocal char(9), codproducto1 int, codproducto2 int)
begin

declare fechatransaccion date;
declare contadortransacciones int;
declare resultado float;
declare contadorProducto2 int;
declare probabilidadproductototal float;
declare nifAli char(9);
declare codAli int;
declare codAliSup int;
declare fec date;

select count(Transaccion) into contadortransacciones
from lineaproducto
where CodigoAlimento=codproducto1 and transaccion in 
	(select LP.Transaccion from lineaproducto LP join actividad A on LP.Transaccion = A.Transaccion
	where CodigoAlimento=codproducto2 and A.NIF=nifLocal and fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date());

select count(transaccion) into contadorProducto2
from lineaproducto
where codproducto2=codigoalimento and transaccion in
				(select transaccion from actividad
				where fecha between (DATE_SUB(current_date(),INTERVAL 6 DAY)) and current_date() and NIF=nifLocal);

set probabilidadproductototal = round(contadortransacciones/contadorproducto2,2);

if probabilidadproductototal is not null and probabilidadproductototal !=0 then

	select NIF, CodigoAlimento, CodigoAlimento2 into nifAli, codAli, codAliSup from secombinacon
    where NIF = nifLocal and CodigoAlimento = codproducto1 and CodigoAlimento2 = codproducto2 and Fecha = current_date();
    
	select Fecha into fec from Fecha
    where Fecha = current_date();

	if nifAli = nifLocal and codAli = codproducto1 and codAliSup = codproducto2 and fec = current_date() then
		update secombinacon set Probabilidad = probabilidadproductototal
		where NIF = nifLocal and CodigoAlimento=codproducto1 and CodigoAlimento2=codproducto2 and Fecha=current_date();
	else
		if fec is null then
			insert into fecha values (current_date());
		end if;
		insert into secombinacon values (nifLocal, codproducto1, codproducto2, current_date(), probabilidadproductototal);
	end if;
end if;
end//