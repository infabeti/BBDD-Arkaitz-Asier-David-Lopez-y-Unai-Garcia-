delimiter //
create function PrecioTotalPedido (TransaccionRecibida int)
returns float
reads sql data

begin
declare PrecioTotalProducto float;
declare CodigoDelPlato int;
declare PVP float;
declare Cantidad int;
declare TipoObtenido enum('TICKET','FACTURA','COMANDA','PEDIDO','APROVISIONAMIENTO');

select tipo into TipoObtenido from actividad where Transaccion = TransaccionRecibida;

if TipoObtenido = 'TICKET' or 'FACTURA' or 'PEDIDO' then
select sum(TotalProducto) into PrecioTotalProducto from lineaproducto where Transaccion = TransaccionRecibida;
return PrecioTotalProducto;

elseif TipoObtenido = 'COMANDA' then
select L.codigoplato into CodigoDelPlato from lineaplato L join plato P on L.codigoplato = P.codigoplato where Transaccion = TransaccionRecibida;
select pvp,cantidad into PVP,Cantidad from lineaplato L join plato P on L.codigoplato = P.codigoplato where L.codigoplato = CodigoDelPlato;
return sum(PVP*Cantidad);
else 
return 0;

end if;

end//

select PrecioTotalPedido (15) "Precio Total";