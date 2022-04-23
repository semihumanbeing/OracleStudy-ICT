package vo;

// 데이터베이스의 column명 == Vo의 property(속성,필드)명 == parameter명(HTML입력폼에서 사용되는 파라미터)

public class DeptVO {
	//dept 테이블의 레코드를 저장하는 VO객체
	
	int deptno;
	String dname;
	String loc;
	
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	

}
