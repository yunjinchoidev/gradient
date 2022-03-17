package project5.procurement;

import java.util.Date;

public class ProcurementVO {
	private int procurementkey;
	private int projectkey;
	private int memberkey;
	private String procurementManagement;
	private Date writedate;
	private String writedateS;
	private String procurementEvaluation;

	public ProcurementVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProcurementVO(int procurementkey, int projectkey, int memberkey, String procurementManagement, Date writedate,
			String procurementEvaluation) {
		super();
		this.procurementkey = procurementkey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.procurementManagement = procurementManagement;
		this.writedate = writedate;
		this.procurementEvaluation = procurementEvaluation;
	}

	public int getProcurementkey() {
		return procurementkey;
	}

	public void setProcurementkey(int procurementkey) {
		this.procurementkey = procurementkey;
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

	public String getProcurementManagement() {
		return procurementManagement;
	}

	public void setProcurementManagement(String procurementManagement) {
		this.procurementManagement = procurementManagement;
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

	public String getProcurementEvaluation() {
		return procurementEvaluation;
	}

	public void setProcurementEvaluation(String procurementEvaluation) {
		this.procurementEvaluation = procurementEvaluation;
	}

}
