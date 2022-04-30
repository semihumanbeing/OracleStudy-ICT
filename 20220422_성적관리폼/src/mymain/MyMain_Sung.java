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

	// 입,출력필드
	JTextField jtf_no, jtf_name, jtf_kor, jtf_eng, jtf_mat, jtf_tot, jtf_avg, jtf_rank;

	// 작업버튼
	JButton jbt_new, jbt_update, jbt_delete, jbt_prev, jbt_next;

	// 조회
	JTable jtb_display;

	// 데이터를 가져갈 리스트 목록
	List<SungVO> sungList = null;

	boolean bAdd = false;// 추가 or 수정작업여부

	int current_pos = -1;// 현재 출력되는 데이터 인덱스

	public MyMain_Sung() {
		// TODO Auto-generated constructor stub
		super("성적관리");// 타이틀

		// 입출력필드 및 작업버튼 초기화
		init_inputs();
		// 조회창 초기화
		init_display();

		// db로부터 목록 가져와서 JTable에 배치
		display_sung_list();

		if (sungList.size() > 0) {
			current_pos = 0;
			// 현재위치의 값을 입력창에 출력하기
			display_input_sung();
		}

		// 버튼활성여부
		enable_buttons();

		// 위치 및 크기지정
		// setBounds(200, 100, 400, 300);
		setLocation(300, 100);

		setResizable(false);

		pack();

		// 보여줘라
		setVisible(true);

		// 종료
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

	private void enable_buttons() {
		// 현재위치가 처음이 아니면 활성화
		jbt_prev.setEnabled(current_pos > 0 && !bAdd);
		// 마지막 첨자보다 작으면 활성화
		jbt_next.setEnabled(current_pos < (sungList.size() - 1) && !bAdd);

		// 삭제버튼 활성여부
		jbt_delete.setEnabled(!bAdd && sungList.size() > 0);

		// 수정버튼 활성여부
		jbt_update.setEnabled(bAdd || sungList.size() > 0);

	}

	private void display_input_sung() {
		// 출력해야할 sungVO정보 얻어오기
		SungVO vo = sungList.get(current_pos);

		jtf_no.setText(vo.getIdx() + "");
		jtf_name.setText(vo.getName());
		jtf_kor.setText(vo.getKor() + "");
		jtf_eng.setText(String.valueOf(vo.getEng())); // int 값을 String으로 생성
		jtf_mat.setText(String.valueOf(vo.getMat()));
		jtf_tot.setText(vo.getTot());
		jtf_avg.setText(vo.getAvg());
		jtf_rank.setText(vo.getRank());

		// JTable에서 행선택기능
		jtb_display.setRowSelectionInterval(current_pos, current_pos);

		// 버튼활성유무결정
		enable_buttons();

	}

	private void display_sung_list() {
		// 1. DB목록 가져오기
		sungList = sungTBDAO.getInstance().selectList();
		// 2. JTable에 배치작업하기
		jtb_display.setModel(new SungTableModel());

	}

	private void init_inputs() {
		// TODO Auto-generated method stub
		JPanel p = new JPanel(new BorderLayout());
		// 입력창
		JPanel p1 = new JPanel(new GridLayout(4, 2));

		p1.add(new JLabel("이름:"));
		p1.add(jtf_name = new JTextField());

		p1.add(new JLabel("번호:"));
		p1.add(jtf_no = new JTextField());

		p1.add(new JLabel("국어:"));
		p1.add(jtf_kor = new JTextField());

		p1.add(new JLabel("총점:"));
		p1.add(jtf_tot = new JTextField());

		p1.add(new JLabel("영어:"));
		p1.add(jtf_eng = new JTextField());

		p1.add(new JLabel("평균:"));
		p1.add(jtf_avg = new JTextField());

		p1.add(new JLabel("수학:"));
		p1.add(jtf_mat = new JTextField());

		p1.add(new JLabel("등수:"));
		p1.add(jtf_rank = new JTextField());

		// 번호/총점/평균/등수 읽기전용으로 만들기
		jtf_no.setEditable(false);
		jtf_tot.setEditable(false);
		jtf_avg.setEditable(false);
		jtf_rank.setEditable(false);

		// 출력창
		JPanel p2 = new JPanel(new GridLayout(1, 5));
		p2.add(jbt_prev = new JButton("이전"));
		p2.add(jbt_new = new JButton("추가"));
		p2.add(jbt_update = new JButton("수정"));
		p2.add(jbt_delete = new JButton("삭제"));
		p2.add(jbt_next = new JButton("다음"));

		p.add(p1, "Center");
		p.add(p2, "South");

		this.add(p, "Center");

		// 버튼이벤트 초기화
		init_button_event();

	}

	private void init_button_event() {
		// TODO Auto-generated method stub
		ActionListener listener = new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				// 이벤트를 발생시킨 버튼
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
		// 정말 수정하시겠습니까?
		int result = JOptionPane.showConfirmDialog(this, "정말 삭제하시겠습니까?", "삭제", JOptionPane.YES_NO_OPTION);

		// yes 가 아니면 끝내기
		if (result != JOptionPane.YES_OPTION)
			return;
		// 삭제하기
		int idx = Integer.parseInt(jtf_no.getText());

		SungVO vo = new SungVO(idx);

		// 1. DB삭제
		int res = sungTBDAO.getInstance().delete(vo.getIdx());
		// 2. 전체 데이터 가져오기

		display_sung_list();

		// 3. 데이터가없으면 clear하기
		if (sungList.size() <= 0)
			clear_input();

		// 4. 마지막이었나?
		if (current_pos >= sungList.size()) {
			current_pos--;
		}
		display_input_sung();

	}

	protected void on_update() {

		// 이름, 국어, 영어, 수학 입력사항 체크
		String name = jtf_name.getText().trim();
		if (name.isEmpty()) {
			JOptionPane.showMessageDialog(this, "이름을 입력하세요");
			jtf_name.setText("");
			jtf_name.requestFocus();
			return;
		}
		int kor = 0, eng = 0, mat = 0;
		// 국어점수
		String str_kor = jtf_kor.getText().trim();
		try {
			kor = Integer.parseInt(str_kor); // kor에 숫자가 아닌 값이 떨어지면 예외처리된다.
			if (kor < 0 || kor > 100)
				throw new Exception();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "국어점수는 0~100사이의 정수만 입력하세요");
			jtf_kor.setText("");
			jtf_kor.requestFocus();
			return;
		}
		// 영어점수
		String str_eng = jtf_eng.getText().trim();
		try {
			eng = Integer.parseInt(str_eng); // eng에 숫자가 아닌 값이 떨어지면 예외처리된다.
			if (eng < 0 || eng > 100)
				throw new Exception();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "영어점수는 0~100사이의 정수만 입력하세요");
			jtf_eng.setText("");
			jtf_eng.requestFocus();
			return;
		}
		// 수학점수
		String str_mat = jtf_mat.getText().trim();
		try {
			mat = Integer.parseInt(str_mat); // mat에 숫자가 아닌 값이 떨어지면 예외처리된다.
			if (mat < 0 || mat > 100)
				throw new Exception();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, "수학점수는 0~100사이의 정수만 입력하세요");
			jtf_mat.setText("");
			jtf_mat.requestFocus();
			return;
		}

		// 등록
		if (bAdd) {
			// 추가할 데이터를 포장
			SungVO vo = new SungVO(name, kor, eng, mat);

			// insert
			int res = sungTBDAO.getInstance().insert(vo);

			// 전체 데이터 갱신
			display_sung_list();

			// 현재 입력된 데이터가 마지막에 있도록 설정
			current_pos = sungList.size() - 1;

			// 입력상태를 초기화시킨다.
			bAdd = false;
			jbt_new.setText("추가");
			jbt_update.setText("수정");
			
			// 입력창에 현재 입력정보 기록
			display_input_sung();
			
			jtf_no.setText("");
			jtf_name.setText("");
			jtf_kor.setText("");
			jtf_eng.setText("");
			jtf_mat.setText("");

		} else {// 수정
			// 정말 수정하시겠습니까?
			int result = JOptionPane.showConfirmDialog(this, "정말 수정하시겠습니까?", "수정", JOptionPane.YES_NO_OPTION);

			// yes 가 아니면 끝내기
			if (result != JOptionPane.YES_OPTION)
				return;
			// 수정하기
			int idx = Integer.parseInt(jtf_no.getText());
			// 1. 수정데이터 포장
			SungVO vo = new SungVO(idx, name, kor, eng, mat);

			// 2. DB업데이트
			int res = sungTBDAO.getInstance().update(vo);
			// 3. 전체 데이터 가져오기
			display_input_sung();
			display_sung_list();

		}

	}

	protected void on_new() {
		bAdd = !bAdd;
		if (bAdd) {
			// 신규등록준비
			clear_input();
		} else {
			// 취소작업
			if (sungList.size() > 0) {
				display_input_sung();
			}

		}

		// 버튼 캡션(타이틀) 변경
		jbt_new.setText(bAdd ? "취소" : "추가");
		jbt_update.setText(bAdd ? "등록" : "수정");
		// 버튼 활성 유무
		enable_buttons();

	}

	private void clear_input() {
		// 모든 입력 컨트롤 지우기
		jtf_no.setText("");
		jtf_name.setText("");
		jtf_kor.setText("");
		jtf_eng.setText(""); // int 값을 String으로 생성
		jtf_mat.setText("");
		jtf_tot.setText("");
		jtf_avg.setText("");
		jtf_rank.setText("");

		// 이름에 포커스
		jtf_name.requestFocus();
	}

	private void init_display() {
		// TODO Auto-generated method stub
		jtb_display = new JTable();
		JScrollPane jsp = new JScrollPane(jtb_display);

		jsp.setPreferredSize(new Dimension(400, 200));

		this.add(jsp, "South");

		// 마우스이벤트(JTable에서 마우스가 클릭되면)
		jtb_display.addMouseListener(new MouseAdapter() {
			@Override
			public void mousePressed(MouseEvent e) {
				current_pos = jtb_display.getSelectedRow();
				display_input_sung();
			}

		});

	}

	// SungTableModel 설계하기
	class SungTableModel extends AbstractTableModel {

		// 타이틀
		String[] title = { "번호", "이름", "국어", "영어", "수학", "총점", "평균", "등수" };

		// 행의 갯수(데이터갯수)
		@Override
		public int getRowCount() {
			return sungList.size();
		}

		// 타이틀 배치
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