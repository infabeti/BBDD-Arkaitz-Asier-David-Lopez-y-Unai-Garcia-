package principal;

public class SentenciasBBDD {

	// CONSULTAS BBDD
		public final String CONSULTALOGUEAR = "Select e.nombre, es.nombre, tipoNegocio, e.NIF from empleado e join establecimiento es on e.NIF = es.NIF where dni=? and contrasena=?";
		public final String CONSULTANIF = "Select nif from empleado where NIF=?";
		public final String CONSULATDNI = "Select dni from empleado where dni=?";
		public final String CONSULTAACTIVIDAD = "select * from actividad;";
		public final String CONSULTAALIMENTO = "select * from alimento ;";
		public final String INSERTARACTIVIDAD = "insert into actividad " + "values(?,?,?,?,?);";
		public final String INSERTAREMPLEADO = "insert into empleado " + "values(?, ?, ?, ?, ?)";
		public final String INSERTARPRODUCTOACTIVIDAD = "insert into lineaproducto (codigoalimento,transaccion,cantidad,preciofinal)" + "values(?,?,?,?);";
		public final String CONSULTAPRODUCTOLOCAL = "Select a.Nombre, a.PCompra, p.PVenta, a.Tipo, a.FeCad from alimento a join producto p on a.CodigoAlimento = p.CodigoAlimento join stock s on a.CodigoAlimento = s.CodigoAlimento where s.NIF=?";
		public final String INSERTARPEDIDO = "insert into pedido " + "values(?, ?)";
		public final String INSERTARFACTURA = "insert into factura " + "values(?,?);";
		public final String INSERTARCOMPRADOR = "insert into comprador " + "values(?,?,?);";
		public final String EXISTECOMPRADOR = "select * from comprador where NIF=?;";
		public final String CONSEGUIRCANTIDADSTOCK = "select Cantidad from stock where CodigoAlimento = (select CodigoAlimento from alimento where nombre=?) and nif =?;";
		public final String REPLACESTOCK = "replace into stock " + "values(?, ?, ?)";
		public final String INSERTARCOMANDA = "insert into comanda " + "values(?)";
		public final String CONSULTAPLATO = "select * from plato ;";
		public final String ALIMENTOORDENADO = "Select a.Nombre, a.PCompra, a.Tipo, a.FeCad from alimento a order by a.CodigoAlimento asc";
		public final String PLATOJOINCARTA = "Select p.Nombre, p.pvp from plato p join carta c on p.codigoplato = c.codigoplato where c.nif=?";
		public final String INSERTARAPROVISIONAMIENTO = "insert into aprovisionamiento " + "values(?,0)";	
		public final String CONSEGUIRNIFPORTRANS = "select nif from actividad where Transaccion = (select transaccion from lineaproducto where Transaccion =?)";
		public final String CODIGOALIMENTO = "SELECT cantidad from stock where CodigoAlimento =? and NIF=?";
		public final String PRECIOALIMENTO = "SELECT pcompra from alimento where CodigoAlimento =?";
		public final String ACTUALIZARSTOCK = "update stock set cantidad=? where nif=? and codigoalimento=?";
		public final String COMPROBARSIESAPROVISIONAMIENTO = "select tipo from actividad where transaccion=?";
		public final String CONSEGUIRPRECIOPRODUCTO = "select PCompra from alimento where nombre=?";
		public final String LLAMADAPROCEDIMIENTO = "{call PrecioTotalPedido(?)}";
		public final String DATOSACTIVIDADES = "select a.Transaccion, a.Fecha, a.NIF, al.Nombre, al.CodigoAlimento from actividad a join lineaproducto lp on a.Transaccion = lp.Transaccion join alimento al on al.CodigoAlimento = lp.CodigoAlimento where a.Tipo != 'aprovisionamiento'";
}

	