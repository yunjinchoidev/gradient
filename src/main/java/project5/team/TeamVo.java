package project5.team;

public class TeamVo {
	private String name;
	private String auth;
	private String projectname;
	private String progress;
	private String dname;
	public TeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamVo(String name, String auth, String projectname, String progress, String dname) {
		super();
		this.name = name;
		this.auth = auth;
		this.projectname = projectname;
		this.progress = progress;
		this.dname = dname;
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
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
}
