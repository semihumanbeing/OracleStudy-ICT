package mymain.test;

import java.util.List;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;

import dao.sungTBDAO;
import vo.SungVO;

public class TableTest extends JFrame {

	List<SungVO> list = null;

	JTable jtbDisplay;

	// 내부클래스로 JTable의 배치 모델 설계
	class MyTableModel extends AbstractTableModel {

		// 타이틀 배열
		String[] title = { "번호", "이름", "국어", "영어", "수학", "총점", "평균", "등수" };

		// 타이틀 설정
		@Override
		public String getColumnName(int column) {
			return title[column];
		}

		// 행의 갯수 결정
		@Override
		public int getRowCount() {
			// TODO Auto-generated method stub
			return list.size();
		}

		// 열의 갯수 결정
		@Override
		public int getColumnCount() {
			// TODO Auto-generated method stub
			return title.length;
		}

		// JTable cell에 데이터 채우기
		@Override
		public Object getValueAt(int rowIndex, int columnIndex) {
			SungVO vo = list.get(rowIndex);
			if (columnIndex == 0) {
				return vo.getIdx();
			} else if (columnIndex == 1) {
				return vo.getName();
			} else if (columnIndex == 2) {
				return vo.getKor();
			} else if (columnIndex == 3) {
				return vo.getEng();
			} else if (columnIndex == 4) {
				return vo.getMat();
			} else if (columnIndex == 5) {
				return vo.getTot();
			} else if (columnIndex == 6) {
				return vo.getAvg();
			} return vo.getRank();
		}

	}

	public TableTest() {
		// TODO Auto-generated constructor stub
		super("JTable 연습");

		// DB에서 데이터 가져오기
		list = sungTBDAO.getInstance().selectList();

		jtbDisplay = new JTable();
		JScrollPane jsp = new JScrollPane(jtbDisplay);
		this.add(jsp);

		// 배치 모델 적용
		jtbDisplay.setModel(new MyTableModel());

		// 위치 x y
		this.setLocation(200, 100);

		// 크기
		this.setSize(400, 400);

		// 보여주기
		this.setVisible(true);

		// 종료
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new TableTest();
	}

}