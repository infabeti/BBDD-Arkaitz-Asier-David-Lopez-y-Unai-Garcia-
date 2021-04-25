delimiter //
create function PrecioTotalPedido (TransaccionRecibida int)
returns float
reads sql data

begin
	declare PrecioTotalProducto float;
	declare PrecioTotalPlato float;
	declare CodigoDelPlato int;
	declare PVP float;
	declare Cantidad int;
	declare TipoObtenido enum('TICKET','FACTURA','COMANDA','PEDIDO','APROVISIONAMIENTO');

	select tipo into TipoObtenido from actividad where Transaccion = TransaccionRecibida;

	if TipoObtenido = 'TICKET' or 'FACTURA' or 'PEDIDO' then
		select sum(TotalProducto) into PrecioTotalProducto from lineaproducto where Transaccion = TransaccionRecibida;
		return round(PrecioTotalProducto,2);

	elseif TipoObtenido = 'COMANDA' then
		select sum(TotalProducto) into PrecioTotalProducto from lineaproducto where Transaccion = TransaccionRecibida;
		select sum(P.pvp*L.cantidad) into PrecioTotalPlato from lineaplato L join plato P on L.codigoplato = P.codigoplato where Transaccion = TransaccionRecibida;
		return round(PrecioTotalProducto + PrecioTotalPlato,2);
	else 
		return 0;

	end if;

end;//

select PrecioTotalPedido (0) "Precio Total";