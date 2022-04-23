package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBService;
import vo.DeptVO;

public class DeptDAO {

	static DeptDAO single = null;

	public static DeptDAO getInstance() {
		if (single == null)
			single = new DeptDAO();

		return single;
	}

	private DeptDAO() {
		// 프라이빗 생성자를 만들어주어 외부에서 생성되지 않도록 한다.

	}

	// CRUD메서드 구현
	// 전체조회
	public List<DeptVO> selectList() {
		List<DeptVO> list = new ArrayList<DeptVO>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from dept";

		try {
			// 1. connection 얻어오기
			connection = DBService.getInstance().getConnection(); // connection 은 연결하고나면 꼭 닫아준다.
			// 2. prepared statement 얻어오기
			pstmt = connection.prepareStatement(sql);
			// 3. result set 구하기
			rs = pstmt.executeQuery();
			// 4. 포장하기
			while(rs.next()) {
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				String loc = rs.getString("loc");
				
				// vo로 포장
				DeptVO vo = new DeptVO();
				vo.setDeptno(deptno);
				vo.setDname(dname);
				vo.setLoc(loc);
				
				// while 문 한바퀴마다 vo에서 값을 얻어와서 리스트에 추가한다.
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// 연결되어있으면 close 해준다.(열린 역순으로)
				if (rs != null)	rs.close(); // 3.
				if (pstmt != null)	pstmt.close(); // 2.
				if (connection != null)	connection.close(); // 1.
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return list;
	}
	

}
