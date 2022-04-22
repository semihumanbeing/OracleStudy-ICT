package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MyMain_DBTest3_SQLInjectionNotWorking {
	
	// �����ͺ��̽��� DB����̹��� ���α׷��� ���۵Ǳ� ���� static �ʱ�ȭ�� ���� �÷��ش�.
	static {
		//new OracleDriver(); 
		// �̷������� �ε��ϰ� �Ǹ� ����̹��� �������� ���ư��ԵǴ� ������ �����.
		// �켱 �̰� ����ؼ� ����̹��� �ּҸ� �ľ��ϰ� Class.forName �� ����ؼ� �ּҸ� �ҷ������� ���ش�.
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws SQLException {
		// 1. Connection ������
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "test";
		String pwd = "test";
		
		Connection connection = DriverManager.getConnection(url, user, pwd);
		System.out.println("connection succeed!");
		
		// 2. Statement ������: SQL���ó����ü             index1        index2
		String sql = "select * from testMember where id = ? and pwd = ?";
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		// 3. ResultSet���� ��ȸ�ϱ�: ����� ó����ü
		pstmt.setString(1, "gildong1");
		pstmt.setString(2, "1234");
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) { // rs.next()�� ���� Ŀ������ ������� �����Ϳ������� Ȯ���ϴ� boolean
			
			int idx = rs.getInt("idx");
			String id = rs.getString("id");
			String pass = rs.getString("pwd");
			String name = rs.getString("name");
			
			System.out.printf("%d-%s-%s-%s\n", idx,id,pass,name);
			
		}
		
		// 4. Ŀ�ؼ� ���� (���� �� ������ �ݴ´�)
		rs.close();
		pstmt.close();
		connection.close();
		
	}

}
