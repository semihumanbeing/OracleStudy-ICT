package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBService;
import vo.DeptVO;

public class TestDAO {
	
	static TestDAO single = null;

	public static TestDAO getInstance() {
		if (single == null)
			single = new TestDAO();

		return single;
	}

	private TestDAO() {
		// �����̺� �����ڸ� ������־� �ܺο��� �������� �ʵ��� �Ѵ�.

	}
	
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
			while (rs.next()) {
				// rs�� ����Ű�� ���� ���� �о�´�.
				

				// vo�� ����
				DeptVO vo = new DeptVO();

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
