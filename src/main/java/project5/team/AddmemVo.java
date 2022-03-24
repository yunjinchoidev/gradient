package project5.team;

public class AddmemVo {
	private String name;
	private String email;
	private String prjname;
	private String auth;
	private String dname;
	private String etc;
	public AddmemVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AddmemVo(String name, String email, String prjname, String auth, String dname, String etc) {
		super();
		this.name = name;
		this.email = email;
		this.prjname = prjname;
		this.auth = auth;
		this.dname = dname;
		this.etc = etc;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPrjname() {
		return prjname;
	}
	public void setPrjname(String prjname) {
		this.prjname = prjname;
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
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
}
