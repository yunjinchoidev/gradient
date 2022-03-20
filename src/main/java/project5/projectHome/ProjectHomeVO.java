package project5.projectHome;

import java.util.Date;

public class ProjectHomeVO {
	private int projectHomekey;
	private String title;
	private String contents;
	private int memberkey;
	private int projectkey;
	private int workSortkey;
	private String importance;
	private Date writedate;
	private String writedateS;
	
	private String workSortTitle;
	
	
	

	public ProjectHomeVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProjectHomeVO(int projectHomekey, String title, String contents, int memberkey, int projectkey,
			int workSortkey, String importance, Date writedate, String writedateS) {
		super();
		this.projectHomekey = projectHomekey;
		this.title = title;
		this.contents = contents;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.workSortkey = workSortkey;
		this.importance = importance;
		this.writedate = writedate;
		this.writedateS = writedateS;
	}

	
	
	
	
	public ProjectHomeVO(int projectHomekey, String title, String contents, int memberkey, int projectkey,
			int workSortkey, String importance, Date writedate, String writedateS, String workSortTitle) {
		super();
		this.projectHomekey = projectHomekey;
		this.title = title;
		this.contents = contents;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.workSortkey = workSortkey;
		this.importance = importance;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.workSortTitle = workSortTitle;
	}

	public int getProjectHomekey() {
		return projectHomekey;
	}

	public void setProjectHomekey(int projectHomekey) {
		this.projectHomekey = projectHomekey;
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

	public int getWorkSortkey() {
		return workSortkey;
	}

	public void setWorkSortkey(int workSortkey) {
		this.workSortkey = workSortkey;
	}

	public String getImportance() {
		return importance;
	}

	public void setImportance(String importance) {
		this.importance = importance;
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

	public String getWorkSortTitle() {
		return workSortTitle;
	}

	public void setWorkSortTitle(String workSortTitle) {
		this.workSortTitle = workSortTitle;
	}
	
	
	

}