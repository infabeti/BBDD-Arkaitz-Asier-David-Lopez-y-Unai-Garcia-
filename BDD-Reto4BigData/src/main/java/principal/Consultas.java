package principal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Consultas {

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