package dao;

import java.sql.*;

public class DBUtil {
	// db연결 dao 메시드들에 공통으로 중복됨 -> 하나의 이름으로(메서드) 따로 분리
	// 입력값과 반환값을 결정해야함
	// 입력값X 반환값은 connection타입 반환
	public Connection getConnection() throws Exception {
		String driver = "org.mariadb.jdbc.Driver"; 
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
		// 3가지 꼭 모두 사용안함 사용하는것만 -> null값 아니면 close
		try {
			if(rs != null) {
				rs.close(); 
			}
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
