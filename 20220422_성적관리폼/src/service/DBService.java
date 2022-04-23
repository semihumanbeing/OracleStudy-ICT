package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBService {
	
	//제일 처음 오라클 드라이버를 로딩하는 스태틱 초기화 작업을 해야한다.
	// (ojdbc14.jar 파일을 쓸 때는 필수적으로 해야하지만
	// ojdbc6.jar 파일을 쓸 때는 생략해도 되는 과정이다.
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	static DBService single = null;

	public static DBService getInstance() {
		// 객체가 없으면 생성하기
		if (single == null)
			single = new DBService();

		return single;
	}

	private DBService() {
		// 프라이빗 생성자를 만들어주어 외부에서 생성되지 않도록 한다.

	}
	
	// 커넥션 연결관리하는 메서드
	public Connection getConnection() throws SQLException {
		Connection connection = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "test";
		String pwd = "test";
		
		// getConnection 을 쓰는 사용자에게 exception을 위임해준다.
		connection = DriverManager.getConnection(url,user,pwd); 
		
		return connection;
	}
	
	
	
}
