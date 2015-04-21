package SQLHelper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Helper {
	
	public static Connection openDBConnection(){
		Connection conn = null;
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://cs336-8.cs.rutgers.edu:3306/Luckerdogs";
		String username = "csuser";
		String password = "cs8d4896";

		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
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
	
	public static void printPoop() {
		System.out.print("poop");
	}
}
