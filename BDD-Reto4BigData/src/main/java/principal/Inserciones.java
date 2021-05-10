package principal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Inserciones {

	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	private Conexion conexion;

	public Inserciones(Conexion conexion) {
		this.conexion = conexion;
	}
	
	public void realizarInsercion(PreparedStatement st) {
		try {
			st.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean ejecutarFuncion(CallableStatement cs) {
		try {
			cs.executeUpdate();
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}