package mymain;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.AbstractTableModel;

import dao.sungTBDAO;
import vo.SungVO;

public class MyMain_Sung extends JFrame {

	// ��,����ʵ�
	JTextField jtf_no, jtf_name, jtf_kor, jtf_eng, jtf_mat, jtf_tot, jtf_avg, jtf_rank;

	// �۾���ư
	JButton jbt_new, jbt_update, jbt_delete, jbt_prev, jbt_next;

	// ��ȸ
	JTable jtb_display;

	// �����͸� ������ ����Ʈ ���
	List<SungVO> sungList = null;

	boolean bAdd = false;// �߰� or �����۾�����

	int current_pos = -1;// ���� ��µǴ� ������ �ε���

	public MyMain_Sung() {
		// TODO Auto-generated constructor stub
		super("��������");// Ÿ��Ʋ

		// ������ʵ� �� �۾���ư �ʱ�ȭ
		init_inputs();
		// ��ȸâ �ʱ�ȭ
		init_display();

		// db�κ��� ��� �����ͼ� JTable�� ��ġ
		display_sung_list();

		if (sungList.size() > 0) {
			current_pos = 0;
			// ������ġ�� ���� �Է�â�� ����ϱ�
			display_input_sung();
		}

		// ��ưȰ������
		enable_buttons();

		// ��ġ �� ũ������
		// setBounds(200, 100, 400, 300);
		setLocation(300, 100);

		setResizable(false);

		pack();

		// �������
		setVisible(true);

		// ����
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

	private void enable_buttons() {
		// ������ġ�� ó���� �ƴϸ� Ȱ��ȭ
		jbt_prev.setEnabled(current_pos > 0 && !bAdd);
		// ������ ÷�ں��� ������ Ȱ��ȭ
		jbt_next.setEnabled(current_pos < (sungList.size() - 1) && !bAdd);

		// ������ư Ȱ������
		jbt_delete.setEnabled(!bAdd && sungList.size() > 0);

		// ������ư Ȱ������
		jbt_update.setEnabled(bAdd || sungList.size() > 0);

	}

	private void display_input_sung() {
		// ����ؾ��� sungVO���� ������
		SungVO vo = sungList.get(current_pos);

		jtf_no.setText(vo.getIdx() + "");
		jtf_name.setText(vo.getName());
		jtf_kor.setText(vo.getKor() + "");
		jtf_eng.setText(String.valueOf(vo.getEng())); // int ���� String���� ����
		jtf_mat.setText(String.valueOf(vo.getMat()));
		jtf_tot.setText(vo.getTot());
		jtf_avg.setText(vo.getAvg());
		jtf_rank.setText(vo.getRank());

		// JTable���� �༱�ñ��
		jtb_display.setRowSelectionInterval(current_pos, current_pos);

		// ��ưȰ����������
		enable_buttons();

	}

	private void display_sung_list() {
		// 1. DB��� ��������
		sungList = sungTBDAO.getInstance().selectList();
		// 2. JTable�� ��ġ�۾��ϱ�
		jtb_display.setModel(new SungTableModel());

	}

	private void init_inputs() {
		// TODO Auto-generated method stub
		JPanel p = new JPanel(new BorderLayout());
		// �Է�â
		JPanel p1 = new JPanel(new GridLayout(4, 2));

		p1.add(new JLabel("�̸�:"));
		p1.add(jtf_name = new JTextField());

		p1.add(new JLabel("��ȣ:"));
		p1.add(jtf_no = new JTextField());

		p1.add(new JLabel("����:"));
		p1.add(jtf_kor = new JTextField());

		p1.add(new JLabel("����:"));
		p1.add(jtf_tot = new JTextField());

		p1.add(new JLabel("����:"));
		p1.add(jtf_eng = new JTextField());

		p1.add(new JLabel("���:"));
		p1.add(jtf_avg = new JTextField());

		p1.add(new JLabel("����:"));
		p1.add(jtf_mat = new JTextField());

		p1.add(new JLabel("���:"));
		p1.add(jtf_rank = new JTextField());

		// ��ȣ/����/���/��� �б��������� �����
		jtf_no.setEditable(false);
		jtf_tot.setEditable(false);
		jtf_avg.setEditable(false);
		jtf_rank.setEditable(false);

		// ���â
		JPanel p2 = new JPanel(new GridLayout(1, 5));
		p2.add(jbt_prev = new JButton("����"));
		p2.add(jbt_new = new JButton("�߰�"));
		p2.add(jbt_update = new JButton("����"));
		p2.add(jbt_delete = new JButton("����"));
		p2.add(jbt_next = new JButton("����"));

		p.add(p1, "Center");
		p.add(p2, "South");

		this.add(p, "Center");

		// ��ư�̺�Ʈ �ʱ�ȭ
		init_button_event();

	}

	private void init_button_event() {
		// TODO Auto-generated method stub
		ActionListener listener = new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				// �̺�Ʈ�� �߻���Ų ��ư
				Object evt_src = e.getSource();

				if (evt_src == jbt_new)
					on_new();
				else if (evt_src == jbt_update)
					on_update();
				else if (evt_src == jbt_delete)
					on_delete();
				else if (evt_src == jbt_prev)
					on_prev();
				else if (evt_src == jbt_next)
					on_next();

			}
		};

		jbt_new.addActionListener(listener);
		jbt_update.addActionListener(listener);
		jbt_delete.addActionListener(listener);
		jbt_prev.addActionListener(listener);
		jbt_next.addActionListener(listener);

	}

	protected void on_next() {
		current_pos++;
		display_input_sung();

	}

	protected void on_prev() {
		current_pos--;
		display_input_sung();

	}

	protected void on_delete() {
		// ���� �����Ͻðڽ��ϱ�?
		int result = JOptionPane.showConfirmDialog(this, "���� �����Ͻðڽ��ϱ�?", "����", JOptionPane.YES_NO_OPTION);

		// yes �� �ƴϸ� ������
		if (result != JOptionPane.YES_OPTION)
			return;
		// �����ϱ�
		int idx = Integer.parseInt(jtf_no.getText());

		SungVO vo = new SungVO(idx);

		// 1. DB����
		int res = sungTBDAO.getInstance().delete(vo.getIdx());
		// 2. ��ü ������ ��������

		display_sung_list();

		// 3. �����Ͱ������� clear�ϱ�
		if (sungList.size() <= 0)
			clear_input();

		// 4. �������̾���?
		if (current_pos >= sungList.size()) {
			current_pos--;
		}
		display_input_sung();

	}

	protected void on_update() {

		// �̸�, ����, ����, ���� �Է»��� üũ
		String name = jtf_name.getText().trim();
		if (name.isEmpty()) {
			JOptionPane.showMessageDialog(this, "�̸��� �Է��ϼ���");
			jtf_name.setText("");
			jtf_name.requestFocus();
			return;
		}
		int kor = 0, eng = 0, mat = 0;
		// ��������
		String str_kor = jtf_kor.getText().trim();
		try {
			kor = Integer.parseInt(str_kor); // kor�� ���ڰ� �ƴ� ���� �������� ����ó���ȴ�.
			if (kor < 0 || kor > 100)
				throw new Exception();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "���������� 0~100������ ������ �Է��ϼ���");
			jtf_kor.setText("");
			jtf_kor.requestFocus();
			return;
		}
		// ��������
		String str_eng = jtf_eng.getText().trim();
		try {
			eng = Integer.parseInt(str_eng); // eng�� ���ڰ� �ƴ� ���� �������� ����ó���ȴ�.
			if (eng < 0 || eng > 100)
				throw new Exception();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "���������� 0~100������ ������ �Է��ϼ���");
			jtf_eng.setText("");
			jtf_eng.requestFocus();
			return;
		}
		// ��������
		String str_mat = jtf_mat.getText().trim();
		try {
			mat = Integer.parseInt(str_mat); // mat�� ���ڰ� �ƴ� ���� �������� ����ó���ȴ�.
			if (mat < 0 || mat > 100)
				throw new Exception();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "���������� 0~100������ ������ �Է��ϼ���");
			jtf_mat.setText("");
			jtf_mat.requestFocus();
			return;
		}

		// ���
		if (bAdd) {
			// �߰��� �����͸� ����
			SungVO vo = new SungVO(name, kor, eng, mat);

			// insert
			int res = sungTBDAO.getInstance().insert(vo);

			// ��ü ������ ����
			display_sung_list();

			// ���� �Էµ� �����Ͱ� �������� �ֵ��� ����
			current_pos = sungList.size() - 1;

			// �Է»��¸� �ʱ�ȭ��Ų��.
			bAdd = false;
			jbt_new.setText("�߰�");
			jbt_update.setText("����");
			
			// �Է�â�� ���� �Է����� ���
			display_input_sung();
			
			jtf_no.setText("");
			jtf_name.setText("");
			jtf_kor.setText("");
			jtf_eng.setText("");
			jtf_mat.setText("");

		} else {// ����
			// ���� �����Ͻðڽ��ϱ�?
			int result = JOptionPane.showConfirmDialog(this, "���� �����Ͻðڽ��ϱ�?", "����", JOptionPane.YES_NO_OPTION);

			// yes �� �ƴϸ� ������
			if (result != JOptionPane.YES_OPTION)
				return;
			// �����ϱ�
			int idx = Integer.parseInt(jtf_no.getText());
			// 1. ���������� ����
			SungVO vo = new SungVO(idx, name, kor, eng, mat);

			// 2. DB������Ʈ
			int res = sungTBDAO.getInstance().update(vo);
			// 3. ��ü ������ ��������
			display_input_sung();
			display_sung_list();

		}

	}

	protected void on_new() {
		bAdd = !bAdd;
		if (bAdd) {
			// �űԵ���غ�
			clear_input();
		} else {
			// ����۾�
			if (sungList.size() > 0) {
				display_input_sung();
			}

		}

		// ��ư ĸ��(Ÿ��Ʋ) ����
		jbt_new.setText(bAdd ? "���" : "�߰�");
		jbt_update.setText(bAdd ? "���" : "����");
		// ��ư Ȱ�� ����
		enable_buttons();

	}

	private void clear_input() {
		// ��� �Է� ��Ʈ�� �����
		jtf_no.setText("");
		jtf_name.setText("");
		jtf_kor.setText("");
		jtf_eng.setText(""); // int ���� String���� ����
		jtf_mat.setText("");
		jtf_tot.setText("");
		jtf_avg.setText("");
		jtf_rank.setText("");

		// �̸��� ��Ŀ��
		jtf_name.requestFocus();
	}

	private void init_display() {
		// TODO Auto-generated method stub
		jtb_display = new JTable();
		JScrollPane jsp = new JScrollPane(jtb_display);

		jsp.setPreferredSize(new Dimension(400, 200));

		this.add(jsp, "South");

		// ���콺�̺�Ʈ(JTable���� ���콺�� Ŭ���Ǹ�)
		jtb_display.addMouseListener(new MouseAdapter() {
			@Override
			public void mousePressed(MouseEvent e) {
				current_pos = jtb_display.getSelectedRow();
				display_input_sung();
			}

		});

	}

	// SungTableModel �����ϱ�
	class SungTableModel extends AbstractTableModel {

		// Ÿ��Ʋ
		String[] title = { "��ȣ", "�̸�", "����", "����", "����", "����", "���", "���" };

		// ���� ����(�����Ͱ���)
		@Override
		public int getRowCount() {
			return sungList.size();
		}

		// Ÿ��Ʋ ��ġ
		@Override
		public String getColumnName(int column) {
			return title[column];
		}

		@Override
		public int getColumnCount() {
			return title.length;
		}

		@Override
		public Object getValueAt(int rowIndex, int columnIndex) {
			SungVO vo = sungList.get(rowIndex);
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
			}
			return vo.getRank();
		}

	}

	// ---------------------------

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new MyMain_Sung();
	}

}