package project5.kanban;

import java.util.Date;

public class KanbanVO {

	private int id;
	private String status;
	private String state;
	private String text;
	private String tags;
	private String content;
	private String color;
	private Date writedate;
	private Date duedate;
	private int projectkey;
	private int resourceId;
	private int deptno;

	public KanbanVO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public KanbanVO(int id, String status, String state, String text, String tags, String content, String color,
			Date writedate, Date duedate, int projectkey, int resourceId, int deptno) {
		super();
		this.id = id;
		this.status = status;
		this.state = state;
		this.text = text;
		this.tags = tags;
		this.content = content;
		this.color = color;
		this.writedate = writedate;
		this.duedate = duedate;
		this.projectkey = projectkey;
		this.resourceId = resourceId;
		this.deptno = deptno;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	

	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
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

	public int getResourceId() {
		return resourceId;
	}

	public void setResourceId(int resourceId) {
		this.resourceId = resourceId;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

}
