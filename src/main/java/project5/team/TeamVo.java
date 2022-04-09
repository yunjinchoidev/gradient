package project5.team;

public class TeamVo {
	private int team_member_key;
	private int teamkey;
	private int memberkey;
	private int projectkey;
	private String id;
	private String pass;
	private String name;
	private String auth;
	private int deptno;
	private String email;
	private String dname;
	private int dcnt;
	private String projectname;
	private String status;
	private int memberprojectkey;
	
	
	
	
	
	
	public TeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamVo(int team_member_key, int teamkey, int memberkey, int projectkey, String id, String pass, String name,
			String auth, int deptno, String email, String dname, int dcnt, String projectname, String status,
			int memberprojectkey) {
		super();
		this.team_member_key = team_member_key;
		this.teamkey = teamkey;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.deptno = deptno;
		this.email = email;
		this.dname = dname;
		this.dcnt = dcnt;
		this.projectname = projectname;
		this.status = status;
		this.memberprojectkey = memberprojectkey;
	}
	public int getTeam_member_key() {
		return team_member_key;
	}
	public void setTeam_member_key(int team_member_key) {
		this.team_member_key = team_member_key;
	}
	public int getTeamkey() {
		return teamkey;
	}
	public void setTeamkey(int teamkey) {
		this.teamkey = teamkey;
	}
	public int getMemberkey() {
		return memberkey;
	}
	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}
	public int getProjectkey() {
		return projectkey;
	}
	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
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
	public String getProjectname() {
		return projectname;
	}
	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getmemberprojectkey() {
		return memberprojectkey;
	}
	public void setmemberprojectkey(int memberprojectkey) {
		this.memberprojectkey = memberprojectkey;
	}
}
