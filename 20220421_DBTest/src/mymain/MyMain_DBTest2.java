package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MyMain_DBTest2 {
	
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
		
		// 2. Statement ������: SQL���ó����ü
		Statement stmt = connection.createStatement();
		// Select(��ȸ)  => executeQuery(sql)
		/*
		 * // Select �� => executeUpdate(sql) String sqlCreate =
		 * "create table ttt(no int)"; String sqlDrop = "drop table ttt"; String
		 * sqlInsert = "insert into ttt values(10)"; String sqlUpdate =
		 * "update ttt set no=2 where no=1"; String sqlDelete = "delete from ttt";
		 * stmt.executeUpdate(sqlDrop);
		 */
		
		// 3. ResultSet���� ��ȸ�ϱ�: ����� ó����ü
		String sqlSelect = 
				"select sabun ���, saname �̸�, sasex ����, deptno �μ���, sajob ����, to_char(sahire,'YYYY-MM-DD') �Ի�⵵, sapay ���� from sawon order by sabun";
		ResultSet rs = stmt.executeQuery(sqlSelect);
		while(rs.next()) { // rs.next()�� ���� Ŀ������ ������� �����Ϳ������� Ȯ���ϴ� boolean
			
			// rs�� ��ġ�� ���ڵ带 ����Ų��. -> �� ��ġ�� �÷����� ���´�
			// ������� �Է��Ѵ�.(��ȸ�� �ο��Ǵ� �ӽ� �ʵ��)
			int sabun = rs.getInt("���"); 
			String saname = rs.getString("�̸�");
			String sasex = rs.getString("����");
			int deptno = rs.getInt("�μ���");
			String sajob = rs.getString("����");
			String sahire = rs.getString("�Ի�⵵");
			int sapay = rs.getInt("����");
			
			/*
			 * int deptno = rs.getInt(1); // �÷��� ��ġ���� ����ؼ� ���� ���� ���� �ִ�. 
			 * String dname = rs.getString(2); String loc = rs.getString(3);
			 */
			System.out.printf("%d-%s-%s-%d-%s-%s-%d\n", sabun,saname,sasex,deptno,sajob,sahire,sapay);
			
			
		}
		
		
		
		
		// 4. Ŀ�ؼ� ���� (���� �� ������ �ݴ´�)
		rs.close();
		stmt.close();
		connection.close();
		
	}

}
