package project5.team;

public class TeamVo {
	private int teamkey;
	private int projectkey;
	private int memberkey;
	private String dname;
	public TeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamVo(int teamkey, int projectkey, int memberkey, String dname) {
		super();
		this.teamkey = teamkey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.dname = dname;
	}
	public int getTeamkey() {
		return teamkey;
	}
	public void setTeamkey(int teamkey) {
		this.teamkey = teamkey;
	}
	public int getProjectkey() {
		return projectkey;
	}
	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
	}
	public int getMemberkey() {
		return memberkey;
	}
	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
}
