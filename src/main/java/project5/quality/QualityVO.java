package project5.quality;

import java.util.Date;

public class QualityVO {
	private int qualitykey;
	private int projectkey;
	private int memberkey;
	private Date writedate;
	private String writedateS;
	private String title;
	private String contents;
// 품질 평가
	// 프로젝트 목록
	private int prjkey;
	private String prjname;
	// 품목 평가 항목
	private int evalkey;
	private String evalcontent;
	private String quality;
	
	public QualityVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public QualityVO(int qualitykey, int projectkey, int memberkey, Date writedate, String writedateS, String title,
			String contents) {
		super();
		this.qualitykey = qualitykey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.title = title;
		this.contents = contents;
	}
	
	
	
	public QualityVO(int qualitykey, int projectkey, int memberkey, String writedateS, String title, String contents) {
		super();
		this.qualitykey = qualitykey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.writedateS = writedateS;
		this.title = title;
		this.contents = contents;
	}
	public int getQualitykey() {
		return qualitykey;
	}
	public void setQualitykey(int qualitykey) {
		this.qualitykey = qualitykey;
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
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public String getWritedateS() {
		return writedateS;
	}
	public void setWritedateS(String writedateS) {
		this.writedateS = writedateS;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
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
	public int getEvalkey() {
		return evalkey;
	}
	public void setEvalkey(int evalkey) {
		this.evalkey = evalkey;
	}
	public String getEvalcontent() {
		return evalcontent;
	}
	public void setEvalcontent(String evalcontent) {
		this.evalcontent = evalcontent;
	}
	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
	}
	

}
