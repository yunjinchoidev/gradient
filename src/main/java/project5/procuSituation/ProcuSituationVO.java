package project5.procuSituation;

import java.util.Date;

public class ProcuSituationVO {

	private int procusituationKey;
	private String title;
	private String contents;
	private Date writedate;
	private String writedateS;
	private int memberkey;
	private int projectkey;
	private int cnt;
	private Date plandate;
	private String plandateS;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public ProcuSituationVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProcuSituationVO(int procusituationKey, String title, String contents, Date writedate, String writedateS,
			int memberkey, int projectkey, int cnt, Date plandate, String plandateS) {
		super();
		this.procusituationKey = procusituationKey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.cnt = cnt;
		this.plandate = plandate;
		this.plandateS = plandateS;
	}
	public int getProcusituationKey() {
		return procusituationKey;
	}
	public void setProcusituationKey(int procusituationKey) {
		this.procusituationKey = procusituationKey;
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
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public Date getPlandate() {
		return plandate;
	}
	public void setPlandate(Date plandate) {
		this.plandate = plandate;
	}
	public String getPlandateS() {
		return plandateS;
	}
	public void setPlandateS(String plandateS) {
		this.plandateS = plandateS;
	}
	
	
}
	
	
	
	
	
	
