package principal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Consultas {
	
	static final String Transaccion="select max(Transaccion) from actividad";

	public Consultas() {}
	
	public ResultSet realizarConsulta(PreparedStatement st) {
		ResultSet rs = null;
		try {
			rs = st.executeQuery();
			return rs;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
}