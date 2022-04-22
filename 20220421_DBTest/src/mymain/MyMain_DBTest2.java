package mymain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MyMain_DBTest2 {
	
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
		
		// 2. Statement 얻어오기: SQL명령처리객체
		Statement stmt = connection.createStatement();
		// Select(조회)  => executeQuery(sql)
		/*
		 * // Select 외 => executeUpdate(sql) String sqlCreate =
		 * "create table ttt(no int)"; String sqlDrop = "drop table ttt"; String
		 * sqlInsert = "insert into ttt values(10)"; String sqlUpdate =
		 * "update ttt set no=2 where no=1"; String sqlDelete = "delete from ttt";
		 * stmt.executeUpdate(sqlDrop);
		 */
		
		// 3. ResultSet으로 조회하기: 결과행 처리객체
		String sqlSelect = 
				"select sabun 사번, saname 이름, sasex 성별, deptno 부서명, sajob 직급, to_char(sahire,'YYYY-MM-DD') 입사년도, sapay 연봉 from sawon order by sabun";
		ResultSet rs = stmt.executeQuery(sqlSelect);
		while(rs.next()) { // rs.next()는 다음 커서에서 결과값이 데이터영역인지 확인하는 boolean
			
			// rs의 위치는 레코드를 가리킨다. -> 그 위치의 컬럼값을 얻어온다
			// 헤딩명을 입력한다.(조회시 부여되는 임시 필드명)
			int sabun = rs.getInt("사번"); 
			String saname = rs.getString("이름");
			String sasex = rs.getString("성별");
			int deptno = rs.getInt("부서명");
			String sajob = rs.getString("직급");
			String sahire = rs.getString("입사년도");
			int sapay = rs.getInt("연봉");
			
			/*
			 * int deptno = rs.getInt(1); // 컬럼의 위치값을 사용해서 값을 얻어올 수도 있다. 
			 * String dname = rs.getString(2); String loc = rs.getString(3);
			 */
			System.out.printf("%d-%s-%s-%d-%s-%s-%d\n", sabun,saname,sasex,deptno,sajob,sahire,sapay);
			
			
		}
		
		
		
		
		// 4. 커넥션 종료 (열린 역 순으로 닫는다)
		rs.close();
		stmt.close();
		connection.close();
		
	}

}
