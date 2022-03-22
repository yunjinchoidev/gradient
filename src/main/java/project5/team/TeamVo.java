package project5.team;

public class TeamVo {
	private int teamkey;
	private String prjname;
	private int prjkey;
	private String auth;
	private String progress;
	public TeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamVo(int teamkey, String prjname, int prjkey, String auth, String progress) {
		super();
		this.teamkey = teamkey;
		this.prjname = prjname;
		this.prjkey = prjkey;
		this.auth = auth;
		this.progress = progress;
	}
	public int getTeamkey() {
		return teamkey;
	}
	public void setTeamkey(int teamkey) {
		this.teamkey = teamkey;
	}
	public String getPrjname() {
		return prjname;
	}
	public void setPrjname(String prjname) {
		this.prjname = prjname;
	}
	public int getPrjkey() {
		return prjkey;
	}
	public void setPrjkey(int prjkey) {
		this.prjkey = prjkey;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
}
