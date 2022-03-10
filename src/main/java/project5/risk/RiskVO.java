package project5.risk;

import java.util.Date;

public class RiskVO {
	private int riskkey;
	private int projectkey;
	private int memberkey;
	private String content;
	private String progress;
	private String importance;
	private String title;
	private Date writedate;
	private Date comdate;
	public int getRiskkey() {
		return riskkey;
	}
	public void setRiskkey(int riskkey) {
		this.riskkey = riskkey;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public Date getComdate() {
		return comdate;
	}
	public void setComdate(Date comdate) {
		this.comdate = comdate;
	}
	
	
	
}
