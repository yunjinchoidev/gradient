package project5.attendance;

public class AttendanceVO {
	private int attendancekey;
	private int memberkey;
	private int score;
	
	public AttendanceVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AttendanceVO(int attendancekey, int memberkey, int score) {
		super();
		this.attendancekey = attendancekey;
		this.memberkey = memberkey;
		this.score = score;
	}
	public int getAttendancekey() {
		return attendancekey;
	}
	public void setAttendancekey(int attendancekey) {
		this.attendancekey = attendancekey;
	}
	public int getMemberkey() {
		return memberkey;
	}
	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	
	
}
