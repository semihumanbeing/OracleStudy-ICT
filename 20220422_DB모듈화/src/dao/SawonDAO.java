package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBService;
import vo.SawonVO;

public class SawonDAO {
	
	static SawonDAO single = null;

	public static SawonDAO getInstance() {
		if (single == null)
			single = new SawonDAO();

		return single;
	}

	private SawonDAO() {
		// 프라이빗 생성자를 만들어주어 외부에서 생성되지 않도록 한다.

	}
	
	public List<SawonVO> selectList() {
		List<SawonVO> list = new ArrayList<SawonVO>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select s1.*, to_char(sahire,'YYYY-MM-DD') sahire2 from sawon s1 order by s1.sabun";

		try {
			// 1. connection 얻어오기
			connection = DBService.getInstance().getConnection(); // connection 은 연결하고나면 꼭 닫아준다.
			// 2. prepared statement 얻어오기
			pstmt = connection.prepareStatement(sql);
			// 3. result set 구하기
			rs = pstmt.executeQuery();
			// 4. 포장하기
			while (rs.next()) {
				// rs가 가리키는 행의 값을 읽어온다.
				int sabun = rs.getInt("sabun");
				String saname = rs.getString("saname");
				String sasex = rs.getString("sasex");
				int deptno = rs.getInt("deptno");
				String sahire = rs.getString("sahire2");
				String sajob = rs.getString("sajob");
				int samgr = rs.getInt("samgr");
				int sapay = rs.getInt("sapay");

				// vo로 포장
				SawonVO vo = new SawonVO();
				vo.setSabun(sabun);
				vo.setSaname(saname);
				vo.setSasex(sasex);
				vo.setDeptno(deptno);
				vo.setSahire(sahire);
				vo.setSajob(sajob);
				vo.setSamgr(samgr);
				vo.setSapay(sapay);

				// while 문 한바퀴마다 vo에서 값을 얻어와서 리스트에 추가한다.
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// 연결되어있으면 close 해준다.(열린 역순으로)
				if (rs != null)
					rs.close(); // 3.
				if (pstmt != null)
					pstmt.close(); // 2.
				if (connection != null)
					connection.close(); // 1.
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return list;
	}

}
