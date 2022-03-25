package project5.team;

public class TeamVo {
	private String name;
	private String auth;
	private String email;
	private String dname;
	private int deptno;
	
	
	
	
	
	
	public TeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamVo(String name, String auth, String email, String dname, int deptno) {
		super();
		this.name = name;
		this.auth = auth;
		this.email = email;
		this.dname = dname;
		this.deptno = deptno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
}
