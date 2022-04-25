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
		// 프라이빗 생성자를 만들어주어 외부에서 생성되지 않도록 한다.

	}

	public List<SungVO> selectList() {
		List<SungVO> list = new ArrayList<SungVO>();

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from sungtb_view";

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

				// vo로 포장
				SungVO vo = new SungVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setKor(rs.getInt("kor"));
				vo.setEng(rs.getInt("eng"));
				vo.setMat(rs.getInt("mat"));

				// db에 있는 컬럼 타입과 무관하게 String 형으로 읽어올 수 있다.
				vo.setTot(rs.getString("tot"));
				vo.setAvg(rs.getString("avg"));
				vo.setRank(rs.getString("rank"));

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

	public int insert(SungVO vo) {
		int res = 0;
		Connection connection = null;
		PreparedStatement pstmt = null; // 1 2 3 4 <- parameter index
		String sql = "insert into sungtb values(seq_sungtb_idx.nextVal,?,?,?,?)";
		try {
			// 1. connection 얻어오기
			connection = DBService.getInstance().getConnection();

			// 2. prepared statement 얻어오기
			pstmt = connection.prepareStatement(sql);

			// 3. pstmt에 파라미터 세팅
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getKor());
			pstmt.setInt(3, vo.getEng());
			pstmt.setInt(4, vo.getMat());

			// 4. insert : res <- 처리된 행 수 반환
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close(); // 2
				connection.close(); // 1
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return res;
	}

	public int delete(int idx) {
		int res = 0;
		Connection connection = null;
		PreparedStatement pstmt = null;
		String sql = "delete from sungtb where idx = ?";
		try {
			// 1. connection 얻어오기
			connection = DBService.getInstance().getConnection();
			
			// 2. prepared statement 얻어오기
			pstmt = connection.prepareStatement(sql);
			
			// 3. pstmt에 파라미터 세팅
			pstmt.setInt(1,idx);
			
			// 4. dml(insert,update,delete) : res <- 처리된 행 수 반환
			res = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close(); // 2
				connection.close(); // 1
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return res;
	}

	public int update(SungVO vo) {
		int res = 0;
		Connection connection = null;
		PreparedStatement pstmt = null; //     1 		2 		 3 		  4    			5 <- parameter index
		String sql = "update sungtb set name = ?, kor = ?, eng = ?, mat = ? where idx = ?";
		try {
			// 1. connection 얻어오기
			connection = DBService.getInstance().getConnection();
			
			// 2. prepared statement 얻어오기
			pstmt = connection.prepareStatement(sql);
			
			// 3. pstmt에 파라미터 세팅
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getKor());
			pstmt.setInt(3, vo.getEng());
			pstmt.setInt(4, vo.getMat());
			pstmt.setInt(5, vo.getIdx());
			
			// 4. dml(insert,update,delete) : res <- 처리된 행 수 반환
			res = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close(); // 2
				connection.close(); // 1
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return res;
	}
	
	
}
