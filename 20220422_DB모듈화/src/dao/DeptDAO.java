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
		// �����̺� �����ڸ� ������־� �ܺο��� �������� �ʵ��� �Ѵ�.

	}

	// CRUD�޼��� ����
	// ��ü��ȸ
	public List<DeptVO> selectList() {
		List<DeptVO> list = new ArrayList<DeptVO>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from dept";

		try {
			// 1. connection ������
			connection = DBService.getInstance().getConnection(); // connection �� �����ϰ��� �� �ݾ��ش�.
			// 2. prepared statement ������
			pstmt = connection.prepareStatement(sql);
			// 3. result set ���ϱ�
			rs = pstmt.executeQuery();
			// 4. �����ϱ�
			while(rs.next()) {
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				String loc = rs.getString("loc");
				
				// vo�� ����
				DeptVO vo = new DeptVO();
				vo.setDeptno(deptno);
				vo.setDname(dname);
				vo.setLoc(loc);
				
				// while �� �ѹ������� vo���� ���� ���ͼ� ����Ʈ�� �߰��Ѵ�.
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				// ����Ǿ������� close ���ش�.(���� ��������)
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
