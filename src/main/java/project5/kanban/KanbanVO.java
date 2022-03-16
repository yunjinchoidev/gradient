package project5.kanban;

import java.util.Date;

public class KanbanVO {
	
	private int id;
	private String state;
	private String label;
	private String tags;
	private String contents;
	private Date writedate;
	private Date duedate;
	private int projectkey;
	private int memberkey;
	private int deptno;

	public KanbanVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public KanbanVO(int id, String state, String label, String tags, String contents, Date writedate, Date duedate,
			int projectkey, int memberkey, int deptno) {
		super();
		this.id = id;
		this.state = state;
		this.label = label;
		this.tags = tags;
		this.contents = contents;
		this.writedate = writedate;
		this.duedate = duedate;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.deptno = deptno;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
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

	public Date getDuedate() {
		return duedate;
	}

	public void setDuedate(Date duedate) {
		this.duedate = duedate;
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

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

}
