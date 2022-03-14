package project5.communication;

import java.util.Date;

/*
	minutesKey NUMBER PRIMARY KEY,
	projectKey NUMBER NOT NULL,
	memberKey NUMBER NOT NULL,
	topic varchar2(100),
	attendee varchar2(100),
	partname varchar2(100),
	conferenceDate DATE,
	writeDate DATE,
	updateDate DATE,
	content varchar2(4000),
	shorthand varchar2(4000), 
 */
public class minutesVO {
	private int minutesKey;
	private int projectKey;
	private int memberKey;
	private String topic;
	private String attendee;
	private String partname;
	private Date conferenceDate;
	private String conferenceDateS;
	private Date writeDate;
	private String writeDateS;
	private Date updateDate;
	private String updateDateS;
	private String content;
	private String shorthane;
	
	public minutesVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public minutesVO(int minutesKey, int projectKey, int memberKey, String topic, String attendee, String partname,
			Date conferenceDate, String conferenceDateS, Date writeDate, String writeDateS, Date updateDate,
			String updateDateS, String content, String shorthane) {
		super();
		this.minutesKey = minutesKey;
		this.projectKey = projectKey;
		this.memberKey = memberKey;
		this.topic = topic;
		this.attendee = attendee;
		this.partname = partname;
		this.conferenceDate = conferenceDate;
		this.conferenceDateS = conferenceDateS;
		this.writeDate = writeDate;
		this.writeDateS = writeDateS;
		this.updateDate = updateDate;
		this.updateDateS = updateDateS;
		this.content = content;
		this.shorthane = shorthane;
	}

	public int getMinutesKey() {
		return minutesKey;
	}

	public void setMinutesKey(int minutesKey) {
		this.minutesKey = minutesKey;
	}

	public int getProjectKey() {
		return projectKey;
	}

	public void setProjectKey(int projectKey) {
		this.projectKey = projectKey;
	}

	public int getMemberKey() {
		return memberKey;
	}

	public void setMemberKey(int memberKey) {
		this.memberKey = memberKey;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getAttendee() {
		return attendee;
	}

	public void setAttendee(String attendee) {
		this.attendee = attendee;
	}

	public String getPartname() {
		return partname;
	}

	public void setPartname(String partname) {
		this.partname = partname;
	}

	public Date getConferenceDate() {
		return conferenceDate;
	}

	public void setConferenceDate(Date conferenceDate) {
		this.conferenceDate = conferenceDate;
	}

	public String getConferenceDateS() {
		return conferenceDateS;
	}

	public void setConferenceDateS(String conferenceDateS) {
		this.conferenceDateS = conferenceDateS;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public String getWriteDateS() {
		return writeDateS;
	}

	public void setWriteDateS(String writeDateS) {
		this.writeDateS = writeDateS;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateDateS() {
		return updateDateS;
	}

	public void setUpdateDateS(String updateDateS) {
		this.updateDateS = updateDateS;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getShorthane() {
		return shorthane;
	}

	public void setShorthane(String shorthane) {
		this.shorthane = shorthane;
	}
}
