package mymain.test;

import java.util.ArrayList;
import java.util.List;

import dao.sungTBDAO;
import vo.SungVO;

public class MyMainSungTest {
	
	public static void main(String[] args) {
		
	List<SungVO> list = sungTBDAO.getInstance().selectList();
	
	for(SungVO vo : list) {
		System.out.printf("번호:%d 이름: %s 전체: %s 평균: %s 순위: %s\n", vo.getIdx(),vo.getName(),vo.getTot(),vo.getAvg(),vo.getRank());
	}
	
	}
}
