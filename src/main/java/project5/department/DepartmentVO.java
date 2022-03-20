package project5.department;

public class DepartmentVO {
	private int deptno;
	private String dname;
	private int dcnt;

	public DepartmentVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DepartmentVO(int deptno, String dname, int dcnt) {
		super();
		this.deptno = deptno;
		this.dname = dname;
		this.dcnt = dcnt;
	}

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

	public int getDcnt() {
		return dcnt;
	}

	public void setDcnt(int dcnt) {
		this.dcnt = dcnt;
	}

}
