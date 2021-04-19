package principal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Consultas {
	
	private java.sql.Connection conexionConn;
	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	static final String Transaccion="select max(Transaccion) from actividad";

	public Consultas() {
		conexionConn =  Conexion.getConn();
	}
	
	public Usuario login(String dni, String password) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULTALOGUEAR);
			st.setString(1, dni);
			st.setString(2, password);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				String nombre = rs.getString("nombre");
				String local = rs.getString("es.nombre");
				String tipoNegocio = rs.getString("tipoNegocio");
				String NIF = rs.getString("NIF");
				Usuario user = new Usuario(nombre, local, tipoNegocio, NIF);
				return user;
			} else {
				Usuario user = new Usuario("", "", "", "");
				return user;
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		Usuario user = new Usuario("", "", "", "");
		return user;
	}

	public int leerNumTransBBDD() {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULTAACTIVIDAD);
			ResultSet rs = st.executeQuery();
			int numero = 1;
			try {
				while (rs.next()) {
					numero++;
				}
				return numero;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return 1;
	}
	
	public int obtenerStock(String nif, String codigoAlimento) {
		int cantidadActual = 0;
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.CONSEGUIRCANTIDADSTOCK);
			st.setString(1, codigoAlimento);
			st.setString(2, nif);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				cantidadActual = rs.getInt("cantidad");
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return cantidadActual;
	}

	public String obtenerCodigoAlimentoProducto(String producto) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULTAALIMENTO);
			ResultSet rs = st.executeQuery();
			try {
				while (rs.next()) {
					if (rs.getString("nombre").equalsIgnoreCase(producto)) {
						return rs.getString("codigoalimento");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return null;
	}

	public String obtenerCodigoPlato(String plato) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.CONSULTAPLATO);
			ResultSet rs = st.executeQuery();
			try {
				while (rs.next()) {
					if (rs.getString("nombre").equalsIgnoreCase(plato)) {
						return rs.getString("codigoplato");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return null;
	}
}