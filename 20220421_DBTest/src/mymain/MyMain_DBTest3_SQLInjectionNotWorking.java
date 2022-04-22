package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MyMain_DBTest3_SQLInjectionNotWorking {
	
	// 데이터베이스의 DB드라이버를 프로그램이 시작되기 전에 static 초기화를 통해 올려준다.
	static {
		//new OracleDriver(); 
		// 이런식으로 로드하게 되면 드라이버가 무한으로 돌아가게되는 문제가 생긴다.
		// 우선 이걸 사용해서 드라이버의 주소를 파악하고 Class.forName 을 사용해서 주소를 불러오도록 해준다.
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws SQLException {
		// 1. Connection 얻어오기
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "test";
		String pwd = "test";
		
		Connection connection = DriverManager.getConnection(url, user, pwd);
		System.out.println("connection succeed!");
		
		// 2. Statement 얻어오기: SQL명령처리객체             index1        index2
		String sql = "select * from testMember where id = ? and pwd = ?";
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		// 3. ResultSet으로 조회하기: 결과행 처리객체
		pstmt.setString(1, "gildong1");
		pstmt.setString(2, "1234");
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) { // rs.next()는 다음 커서에서 결과값이 데이터영역인지 확인하는 boolean
			
			int idx = rs.getInt("idx");
			String id = rs.getString("id");
			String pass = rs.getString("pwd");
			String name = rs.getString("name");
			
			System.out.printf("%d-%s-%s-%s\n", idx,id,pass,name);
			
		}
		
		// 4. 커넥션 종료 (열린 역 순으로 닫는다)
		rs.close();
		pstmt.close();
		connection.close();
		
	}

}
