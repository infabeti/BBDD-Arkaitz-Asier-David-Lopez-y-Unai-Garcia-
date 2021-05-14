package principal;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;

public class Inserciones {

	public Inserciones() {}
	
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