package mymain.test;

import java.util.ArrayList;
import java.util.List;

import dao.sungTBDAO;
import vo.SungVO;

public class MyMainSungTest {
	
	public static void main(String[] args) {
		
	List<SungVO> list = sungTBDAO.getInstance().selectList();
	
	for(SungVO vo : list) {
		System.out.printf("��ȣ:%d �̸�: %s ��ü: %s ���: %s ����: %s\n", vo.getIdx(),vo.getName(),vo.getTot(),vo.getAvg(),vo.getRank());
	}
	
	}
}
