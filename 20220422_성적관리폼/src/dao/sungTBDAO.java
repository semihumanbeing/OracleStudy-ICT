package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBService;
import vo.SungVO;

public class sungTBDAO {
	static sungTBDAO single = null;

	public static sungTBDAO getInstance() {
		if (single == null)
			single = new sungTBDAO();

		return single;
	}

	private sungTBDAO() {
		// �����̺� �����ڸ� ������־� �ܺο��� �������� �ʵ��� �Ѵ�.

	}
	
	public List<SungVO> selectList() {
		List<SungVO> list = new ArrayList<SungVO>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from sungtb_view";

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
				SungVO vo = new SungVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setKor(rs.getInt("kor"));
				vo.setEng(rs.getInt("eng"));
				vo.setMat(rs.getInt("mat"));
				
				//db�� �ִ� �÷� Ÿ�԰� �����ϰ� String ������ �о�� �� �ִ�.
				vo.setTot(rs.getString("tot"));
				vo.setAvg(rs.getString("avg"));
				vo.setRank(rs.getString("rank"));

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
