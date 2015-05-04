package SQLHelper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Helper {
	public static void main(String[] args) {
		openDBConnection();
	}
	
	public static Connection openDBConnection(){
		Connection conn = null;
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/luckerdogs";
		String username = "root";
		String password = "lucky";

		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			System.err.println("This went poorly.");
			e.printStackTrace();
			return null;
		}
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			System.err.println("This went really poorly.");
			e.printStackTrace();
			return null;
		}
		return conn;
	}
	
	public static void closeDBConnection(Connection conn) {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
	}
	
}
