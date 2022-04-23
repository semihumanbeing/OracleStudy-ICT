package mymain;

import java.util.List;

import dao.DeptDAO;
import vo.DeptVO;

public class MyMain_Dept {

	public static void main(String[] args) {
		// 부서목록 가져오기
		List<DeptVO> list = DeptDAO.getInstance().selectList();
		for(DeptVO vo:list) {
			System.out.printf("%d-%s-%s\n",vo.getDeptno(),vo.getDname(),vo.getLoc());
		}

	}

}
