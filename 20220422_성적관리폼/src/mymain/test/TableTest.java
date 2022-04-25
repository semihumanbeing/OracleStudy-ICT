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

	// ����Ŭ������ JTable�� ��ġ �� ����
	class MyTableModel extends AbstractTableModel {

		// Ÿ��Ʋ �迭
		String[] title = { "��ȣ", "�̸�", "����", "����", "����", "����", "���", "���" };

		// Ÿ��Ʋ ����
		@Override
		public String getColumnName(int column) {
			return title[column];
		}

		// ���� ���� ����
		@Override
		public int getRowCount() {
			// TODO Auto-generated method stub
			return list.size();
		}

		// ���� ���� ����
		@Override
		public int getColumnCount() {
			// TODO Auto-generated method stub
			return title.length;
		}

		// JTable cell�� ������ ä���
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
		super("JTable ����");

		// DB���� ������ ��������
		list = sungTBDAO.getInstance().selectList();

		jtbDisplay = new JTable();
		JScrollPane jsp = new JScrollPane(jtbDisplay);
		this.add(jsp);

		// ��ġ �� ����
		jtbDisplay.setModel(new MyTableModel());

		// ��ġ x y
		this.setLocation(200, 100);

		// ũ��
		this.setSize(400, 400);

		// �����ֱ�
		this.setVisible(true);

		// ����
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new TableTest();
	}

}