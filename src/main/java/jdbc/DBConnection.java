package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	//DB와 연결객체를 얻는 용도로 만드는 클래스
	public static Connection getConnection() {
		Connection conn=null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");//jdbc 드라이브 로딩
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "1234");
			System.out.println("DB 연결 성공");
			//연결 객체(conn)이용해 db의 데이터를 수정하거나 삭제하거나 할 수 있음
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("DB 연결 실패");
		}
		return conn;
	}
}
