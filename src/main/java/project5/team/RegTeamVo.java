package project5.team;

public class RegTeamVo {
	private int no;
	private String name;
	private String dname;
	private String email;
	public RegTeamVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RegTeamVo(int no, String name, String dname, String email) {
		super();
		this.no = no;
		this.name = name;
		this.dname = dname;
		this.email = email;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
