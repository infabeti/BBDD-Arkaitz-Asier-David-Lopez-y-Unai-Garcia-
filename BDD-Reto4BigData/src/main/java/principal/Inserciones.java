package principal;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Inserciones {

	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	private java.sql.Connection conexionConn;

	public Inserciones(Conexion conexion) {
		conexionConn =  conexion.getConn();
	}
	
	public void realizarInsercion(PreparedStatement st) {
		try {
			st.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean ejecutarFuncion(int transaccion) {
		try {
			CallableStatement cs = null;
			cs = conexionConn.prepareCall(sentenciasBBDD.LLAMADAPROCEDIMIENTO);  
			cs.setInt(1, transaccion);  
			try {
				cs.executeUpdate();
				return true;
			}
			catch(Exception e) {
				e.printStackTrace();
				return false;
			}
			
		}
		catch (SQLException sqlException) {
			sqlException.printStackTrace();
			return false;
		}
	}
}