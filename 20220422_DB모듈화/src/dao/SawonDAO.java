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
		// �����̺� �����ڸ� ������־� �ܺο��� �������� �ʵ��� �Ѵ�.

	}
	
	public List<SawonVO> selectList() {
		List<SawonVO> list = new ArrayList<SawonVO>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select s1.*, to_char(sahire,'YYYY-MM-DD') sahire2 from sawon s1 order by s1.sabun";

		try {
			// 1. connection ������
			connection = DBService.getInstance().getConnection(); // connection �� �����ϰ��� �� �ݾ��ش�.
			// 2. prepared statement ������
			pstmt = connection.prepareStatement(sql);
			// 3. result set ���ϱ�
			rs = pstmt.executeQuery();
			// 4. �����ϱ�
			while (rs.next()) {
				// rs�� ����Ű�� ���� ���� �о�´�.
				int sabun = rs.getInt("sabun");
				String saname = rs.getString("saname");
				String sasex = rs.getString("sasex");
				int deptno = rs.getInt("deptno");
				String sahire = rs.getString("sahire2");
				String sajob = rs.getString("sajob");
				int samgr = rs.getInt("samgr");
				int sapay = rs.getInt("sapay");

				// vo�� ����
				SawonVO vo = new SawonVO();
				vo.setSabun(sabun);
				vo.setSaname(saname);
				vo.setSasex(sasex);
				vo.setDeptno(deptno);
				vo.setSahire(sahire);
				vo.setSajob(sajob);
				vo.setSamgr(samgr);
				vo.setSapay(sapay);

				// while �� �ѹ������� vo���� ���� ���ͼ� ����Ʈ�� �߰��Ѵ�.
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// ����Ǿ������� close ���ش�.(���� ��������)
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
