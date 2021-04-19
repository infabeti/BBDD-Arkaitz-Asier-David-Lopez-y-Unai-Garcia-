package principal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import tipos.*;

public class ConsultasListas {
	
	private java.sql.Connection conexionConn;
	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	static final String Transaccion="select max(Transaccion) from actividad";
	
	public ConsultasListas() {
		conexionConn =  Conexion.getConn();
	}
	
	public ListaProductos cogerProductosLocal(String NIFLocal) {
		ListaProductos listaProd = new ListaProductos();
		try {
			PreparedStatement st = null;

			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULTAPRODUCTOLOCAL);
			st.setString(1, NIFLocal);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				String nombre = rs.getString("a.nombre");
				double pCompra = rs.getDouble("a.PCompra");
				double pVenta = rs.getDouble("p.PVenta");
				String tipo = rs.getString("a.Tipo");
				Date feCad = rs.getDate("a.FeCad");
				Producto prod = new Producto(nombre, feCad, tipo, pCompra, pVenta);
				listaProd.addProducto(prod);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaProd;
	}
	
	public ListaProductos cogerProductosAprovisionamiento() {
		ListaProductos listaProd = new ListaProductos();
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.ALIMENTOORDENADO);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String nombre = rs.getString("a.nombre");
				double pCompra = rs.getDouble("a.PCompra");
				String tipo = rs.getString("a.Tipo");
				Date feCad = rs.getDate("a.FeCad");
				Producto prod = new Producto(nombre, feCad, tipo, pCompra);
				listaProd.addProducto(prod);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaProd;
	}
	
	public ListaPlatos cogerListaPlatos(String NIFLocal) {
		ListaPlatos listaPlatos = new ListaPlatos();
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(
					sentenciasBBDD.PLATOJOINCARTA);
			st.setString(1, NIFLocal);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String nombre = rs.getString("p.Nombre");
				double pvp = rs.getDouble("p.pvp");
				Plato plato = new Plato(nombre, pvp);
				listaPlatos.addPlato(plato);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaPlatos;
	}

}
