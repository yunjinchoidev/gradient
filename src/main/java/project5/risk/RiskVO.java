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
	private String writedates;
	private String comdate;
	// 프로젝트 목록 조회 및 리스크 리스트 조회
	private int prjkey;
	private String prjname;
	// 프로젝트 리스트 조회
	private String name;
	//
	private String id;
	
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
	public String getComdate() {
		return comdate;
	}
	public void setComdate(String comdate) {
		this.comdate = comdate;
	}
	public int getPrjkey() {
		return prjkey;
	}
	public void setPrjkey(int prjkey) {
		this.prjkey = prjkey;
	}
	public String getPrjname() {
		return prjname;
	}
	public void setPrjname(String prjname) {
		this.prjname = prjname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWritedates() {
		return writedates;
	}
	public void setWritedates(String writedates) {
		this.writedates = writedates;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	

		
}
