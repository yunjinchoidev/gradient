package project5.gantt;

import java.util.Date;

public class GanttVO {
	private int id;
	private String text;
	private Date start_date;
	private int duration;
	private int projectkey;
	private int memberkey;

	public GanttVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GanttVO(int id, String text, Date start_date, int duration, int projectkey, int memberkey) {
		super();
		this.id = id;
		this.text = text;
		this.start_date = start_date;
		this.duration = duration;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
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

}
