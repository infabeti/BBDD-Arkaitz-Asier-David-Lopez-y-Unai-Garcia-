package principal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ConsultasListas {
	
	private java.sql.Connection conexionConn;
	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	static final String Transaccion="select max(Transaccion) from actividad";
	
	public ConsultasListas(Conexion conexion) {
		this.conexionConn =  conexion.getConn();
	}
	
	public ArrayList<String[]> cogerProductosLocal(String NIFLocal) {
		ArrayList<String[]> listaProductos = new ArrayList<String[]>();
		String[] datosProducto = new String[5];
		try {
			PreparedStatement st = null;

			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULTAPRODUCTOLOCAL);
			st.setString(1, NIFLocal);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				String nombre = rs.getString("a.nombre");
				datosProducto[0] = nombre;
				String pCompra = Double.toString(rs.getDouble("a.PCompra"));
				datosProducto[1] = pCompra;
				String pVenta = Double.toString(rs.getDouble("p.PVenta"));
				datosProducto[2] = pVenta;
				String tipo = rs.getString("a.Tipo");
				datosProducto[3] = tipo;
				String feCad = rs.getDate("a.FeCad").toString();
				datosProducto[4] = feCad;
				listaProductos.add(datosProducto);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaProductos;
	}
	
	public ArrayList<String[]> cogerProductosAprovisionamiento() {
		ArrayList<String[]> listaProductos = new ArrayList<String[]>();
		String[] datosProducto = new String[5];
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.ALIMENTOORDENADO);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String nombre = rs.getString("a.nombre");
				datosProducto[0] = nombre;
				String pCompra = Double.toString(rs.getDouble("a.PCompra"));
				datosProducto[1] = pCompra;
				String pVenta = Double.toString(rs.getDouble("p.PVenta"));
				datosProducto[2] = pVenta;
				String tipo = rs.getString("a.Tipo");
				datosProducto[3] = tipo;
				String feCad = rs.getDate("a.FeCad").toString();
				datosProducto[4] = feCad;
				listaProductos.add(datosProducto);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaProductos;
	}
	
	public ArrayList<String[]> cogerListaPlatos(String NIFLocal) {
		ArrayList<String[]> listaPlatos = new ArrayList<String[]>();
		String[] datosPlato = new String[2];
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(
					sentenciasBBDD.PLATOJOINCARTA);
			st.setString(1, NIFLocal);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String nombre = rs.getString("p.Nombre");
				datosPlato[0] = nombre;
				String pvp = Double.toString(rs.getDouble("p.pvp"));
				datosPlato[1] = pvp;
				listaPlatos.add(datosPlato);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaPlatos;
	}

}
