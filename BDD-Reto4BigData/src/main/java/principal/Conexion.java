package principal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

	// constructor de la clase
	private final String NOMBREBD = "reto3";
	private final String USUARIO = "root";
	private final String PASSWORD = "elorrieta";
	private String puerto = "3306"; //Puerto default, se le puede dar un nuevo puerto
	private final String URL = "jdbc:mysql://localhost:3306/" + NOMBREBD + "?useUnicode=true&use"
			+ "JDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&" + "serverTimezone=UTC";

	private static Connection conn = null;
	private static Conexion conexion = null;
	
	public static void crearConexion(String puerto) {
		if(conexion == null) {
			conexion = new Conexion(puerto);
		}
	}

	public static Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	// constructor de la clase
	private Conexion(String puerto) {
		try {
			// obtener el driver
			if(puerto.length()>1) {
				this.puerto = puerto;
			}
			Class.forName("com.mysql.cj.jdbc.Driver");

			// obtener la conexion
			conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
			if (conn == null) {
				System.out.println("******************NO SE PUDO CONECTAR " + NOMBREBD);
				System.exit(0);
			} else {
				System.out.println(
						"Conectado correctamente a la base de datos " + NOMBREBD + " con el usuario " + USUARIO);
			}
		} catch (ClassNotFoundException e) {
			System.out.println("ocurre una ClassNotFoundException : " + e.getMessage());
			System.exit(0);
		} catch (SQLException e) {
			System.out.println("ocurre una SQLException: " + e.getMessage());
			System.out.println("Verifique que Mysql est� encendido...");
			System.exit(0);
		}
	}
	
}



