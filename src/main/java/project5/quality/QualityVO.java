package project5.quality;

import java.util.Date;

public class QualityVO {
	private int qualitykey;
	private int projectkey;
	private int memberkey;
	private String qualityManagement;
	private Date writedate;
	private String writedateS;
	private String qualityEvaluation;

	public QualityVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QualityVO(int qualitykey, int projectkey, int memberkey, String qualityManagement, Date writedate,
			String qualityEvaluation) {
		super();
		this.qualitykey = qualitykey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.qualityManagement = qualityManagement;
		this.writedate = writedate;
		this.qualityEvaluation = qualityEvaluation;
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

	public String getQualityManagement() {
		return qualityManagement;
	}

	public void setQualityManagement(String qualityManagement) {
		this.qualityManagement = qualityManagement;
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

	public String getQualityEvaluation() {
		return qualityEvaluation;
	}

	public void setQualityEvaluation(String qualityEvaluation) {
		this.qualityEvaluation = qualityEvaluation;
	}

}
