package project5.member;

public class MemberVO {
	private int memberkey;
	private String id;
	private String pass;
	private String name;
	private String auth;
	private int projectkey;
	private int deptno;
	private String email;

	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberVO(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email) {
		super();
		this.memberkey = memberkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.projectkey = projectkey;
		this.deptno = deptno;
		this.email = email;
	}

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
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

	public int getProjectkey() {
		return projectkey;
	}

	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
