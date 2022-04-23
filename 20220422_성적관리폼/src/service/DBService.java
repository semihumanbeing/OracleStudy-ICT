package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBService {
	
	//���� ó�� ����Ŭ ����̹��� �ε��ϴ� ����ƽ �ʱ�ȭ �۾��� �ؾ��Ѵ�.
	// (ojdbc14.jar ������ �� ���� �ʼ������� �ؾ�������
	// ojdbc6.jar ������ �� ���� �����ص� �Ǵ� �����̴�.
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); 
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	static DBService single = null;

	public static DBService getInstance() {
		// ��ü�� ������ �����ϱ�
		if (single == null)
			single = new DBService();

		return single;
	}

	private DBService() {
		// �����̺� �����ڸ� ������־� �ܺο��� �������� �ʵ��� �Ѵ�.

	}
	
	// Ŀ�ؼ� ��������ϴ� �޼���
	public Connection getConnection() throws SQLException {
		Connection connection = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "test";
		String pwd = "test";
		
		// getConnection �� ���� ����ڿ��� exception�� �������ش�.
		connection = DriverManager.getConnection(url,user,pwd); 
		
		return connection;
	}
	
	
	
}
