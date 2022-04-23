package mymain;

import java.util.List;

import dao.SawonDAO;
import vo.SawonVO;

public class MyMain_Sawon {

	public static void main(String[] args) {
		List<SawonVO> list = SawonDAO.getInstance().selectList();
		
		for(SawonVO vo : list) {
			System.out.printf("%d-%s-%s-%d-%s-%s-%d-%d\n",vo.getSabun(),vo.getSaname(),vo.getSasex(),vo.getDeptno(),vo.getSahire(),vo.getSajob(),vo.getSamgr(),vo.getSapay());
		}
	}

}
