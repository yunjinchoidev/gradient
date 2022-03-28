package project5.communication;

import java.util.Date;

/*
	minutesKey NUMBER PRIMARY KEY,
	memberKey NUMBER NOT NULL,
	projectKey NUMBER NOT NULL,
	deptKey NUMBER NOT NULL,
	topic varchar2(100),
	attendee varchar2(100),
	conferenceDate DATE,
	writeDate DATE,
	updateDate DATE,
	content varchar2(4000),
	shorthand varchar2(4000),
 */
public class minutesVO {
	private int minutesKey;
	private int memberKey;
	private int projectKey;
	private int deptKey;
	private String topic;
	private String attendee;
	private Date conferenceDate;
	private String conferenceDateS;
	private Date writeDate;
	private String writeDateS;
	private Date updateDate;
	private String updateDateS;
	private String content;
	private String shorthand;
	private String id;
	private String mname;
	private String pname;
	private String dname;
	public minutesVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public minutesVO(int minutesKey, int memberKey, int projectKey, int deptKey, String topic, String attendee,
			Date conferenceDate, String conferenceDateS, Date writeDate, String writeDateS, Date updateDate,
			String updateDateS, String content, String shorthand, String id, String mname, String pname, String dname) {
		super();
		this.minutesKey = minutesKey;
		this.memberKey = memberKey;
		this.projectKey = projectKey;
		this.deptKey = deptKey;
		this.topic = topic;
		this.attendee = attendee;
		this.conferenceDate = conferenceDate;
		this.conferenceDateS = conferenceDateS;
		this.writeDate = writeDate;
		this.writeDateS = writeDateS;
		this.updateDate = updateDate;
		this.updateDateS = updateDateS;
		this.content = content;
		this.shorthand = shorthand;
		this.id = id;
		this.mname = mname;
		this.pname = pname;
		this.dname = dname;
	}
	public int getMinutesKey() {
		return minutesKey;
	}
	public void setMinutesKey(int minutesKey) {
		this.minutesKey = minutesKey;
	}
	public int getMemberKey() {
		return memberKey;
	}
	public void setMemberKey(int memberKey) {
		this.memberKey = memberKey;
	}
	public int getProjectKey() {
		return projectKey;
	}
	public void setProjectKey(int projectKey) {
		this.projectKey = projectKey;
	}
	public int getDeptKey() {
		return deptKey;
	}
	public void setDeptKey(int deptKey) {
		this.deptKey = deptKey;
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
	public String getShorthand() {
		return shorthand;
	}
	public void setShorthand(String shorthand) {
		this.shorthand = shorthand;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
}