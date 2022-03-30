package project5.member;


public class AuthVO {

	private int memberkey;
	private String auth;

	public AuthVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AuthVO(int memberkey, String auth) {
		super();
		this.memberkey = memberkey;
		this.auth = auth;
	}

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

}
