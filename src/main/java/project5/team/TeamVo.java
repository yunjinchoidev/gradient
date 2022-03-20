package project5.team;

public class TeamVo {
	private int teamkey;
	private String name;
	private String auth;
	private String dname;
	private String projectname;
	private String progress;
	private String email;
	public TeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamVo(int teamkey, String name, String auth, String dname, String projectname, String progress,
			String email) {
		super();
		this.teamkey = teamkey;
		this.name = name;
		this.auth = auth;
		this.dname = dname;
		this.projectname = projectname;
		this.progress = progress;
		this.email = email;
	}
	public int getTeamkey() {
		return teamkey;
	}
	public void setTeamkey(int teamkey) {
		this.teamkey = teamkey;
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
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getProjectname() {
		return projectname;
	}
	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
