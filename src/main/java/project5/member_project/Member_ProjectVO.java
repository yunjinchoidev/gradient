package project5.member_project;

public class Member_ProjectVO {
	private int member_project_key;
	private int memberkey;
	private int projectkey;

	public Member_ProjectVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member_ProjectVO(int member_project_key, int memberkey, int projectkey) {
		super();
		this.member_project_key = member_project_key;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
	}

	public int getMember_project_key() {
		return member_project_key;
	}

	public void setMember_project_key(int member_project_key) {
		this.member_project_key = member_project_key;
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

}
