package project5.vacation;

public class VacationVO {
	private int vacationkey;
	private int memberkey;
	private int projectkey;
	private int title;
	private int startdate;
	private int duration;
	private int applydate;

	public VacationVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VacationVO(int vacationkey, int memberkey, int projectkey, int title, int startdate, int duration,
			int applydate) {
		super();
		this.vacationkey = vacationkey;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.title = title;
		this.startdate = startdate;
		this.duration = duration;
		this.applydate = applydate;
	}

	public int getVacationkey() {
		return vacationkey;
	}

	public void setVacationkey(int vacationkey) {
		this.vacationkey = vacationkey;
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

	public int getTitle() {
		return title;
	}

	public void setTitle(int title) {
		this.title = title;
	}

	public int getStartdate() {
		return startdate;
	}

	public void setStartdate(int startdate) {
		this.startdate = startdate;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public int getApplydate() {
		return applydate;
	}

	public void setApplydate(int applydate) {
		this.applydate = applydate;
	}

}
