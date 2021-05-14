package principal;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp2.BasicDataSource;

public class Conexion {

	// constructor de la clase
	private final String NOMBREBD = "reto3";
	private final String USUARIO = "root";
	private final String PASSWORD = "elorrieta";
	private String puerto;
	private String URL;
	private BasicDataSource bds;

	public Connection getConn() {
		try {
			return bds.getConnection();
		}
		catch(SQLException e) {
			System.out.println("ocurre una SQLException: " + e.getMessage());
			System.out.println("Verifique que Mysql est� encendido...");
			System.exit(0);
		}
		return null;
	}

	// constructor de la clase
	public Conexion(String puerto) {
		try {
			
			this.puerto = puerto;
			// obtener el driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// obtener la conexion
			URL = "jdbc:mysql://localhost:"+ puerto +"/" + NOMBREBD + "?useUnicode=true&use"
					+ "JDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&" + "serverTimezone=UTC";
			bds = new BasicDataSource();
			bds.setDriverClassName("com.mysql.cj.jdbc.Driver");
			bds.setUsername(USUARIO);
			bds.setPassword(PASSWORD);
			bds.setUrl(URL);
			bds.setMaxOpenPreparedStatements(10);
			bds.setMaxIdle(5);
			bds.setValidationQuery("select 1");
		} catch (ClassNotFoundException e) {
			System.out.println("ocurre una ClassNotFoundException : " + e.getMessage());
			System.exit(0);
		}
	}
	
}



