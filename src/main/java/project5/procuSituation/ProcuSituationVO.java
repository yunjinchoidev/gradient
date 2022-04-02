package project5.procuSituation;

public class ProcuSituationVO {

	private int procusituationKey;
	private String title;
	private String contents;
	private int writedate;
	private String writedateS;
	private int memberkey;
	private int projectkey;
	private int cnt;

	public ProcuSituationVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProcuSituationVO(int procusituationKey, String title, String contents, int writedate, String writedateS,
			int memberkey, int projectkey) {
		super();
		this.procusituationKey = procusituationKey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
	}

	public ProcuSituationVO(int procusituationKey, String title, String contents, String writedateS, int memberkey,
			int projectkey) {
		super();
		this.procusituationKey = procusituationKey;
		this.title = title;
		this.contents = contents;
		this.writedateS = writedateS;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
	}

	
	
	
	
	public ProcuSituationVO(int procusituationKey, String title, String contents, int writedate, String writedateS,
			int memberkey, int projectkey, int cnt) {
		super();
		this.procusituationKey = procusituationKey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.cnt = cnt;
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

	public int getWritedate() {
		return writedate;
	}

	public void setWritedate(int writedate) {
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

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
