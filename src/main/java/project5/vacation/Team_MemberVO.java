package project5.vacation;

public class Team_MemberVO {
	private int Team_Member_key;
	private int teamkey;
	private int memberkey;

	public Team_MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Team_MemberVO(int team_Member_key, int teamkey, int memberkey) {
		super();
		Team_Member_key = team_Member_key;
		this.teamkey = teamkey;
		this.memberkey = memberkey;
	}

	public int getTeam_Member_key() {
		return Team_Member_key;
	}

	public void setTeam_Member_key(int team_Member_key) {
		Team_Member_key = team_Member_key;
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

}
