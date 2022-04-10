package project5.fullCalendar;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

public class Calendar {
	private int id;
	private String title;
	private String start;
	private String start1;
	private String end;
	private String end1;
	private String content;
	private String borderColor;
	private String backgroundColor;
	private String textColor;
	private boolean allDay;
	private int projectkey;
	private int memberkey;

	private int cnt;

	private MultipartFile[] uploadFile;

	private ArrayList<String> fnames;
	
	
	
	
	
	private int fno;

	public Calendar() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Calendar(int id, String title, String start, String end, String content, String borderColor,
			String backgroundColor, String textColor, boolean allDay, int projectkey, int memberkey) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.content = content;
		this.borderColor = borderColor;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
	}

	public Calendar(int id, String title, String start, String start1, String end, String end1, String content,
			String borderColor, String backgroundColor, String textColor, boolean allDay, int projectkey, int memberkey,
			int cnt, MultipartFile[] uploadFile, ArrayList<String> fnames, int fno) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.start1 = start1;
		this.end = end;
		this.end1 = end1;
		this.content = content;
		this.borderColor = borderColor;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.cnt = cnt;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
	}

	public Calendar(int id, String title, String start, String end, String content, String borderColor,
			String backgroundColor, String textColor, boolean allDay, int projectkey, int memberkey,
			MultipartFile[] uploadFile, ArrayList<String> fnames, int fno) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.content = content;
		this.borderColor = borderColor;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
	}

	public Calendar(int id, String title, String start, String start1, String end, String end1, String content,
			String borderColor, String backgroundColor, String textColor, boolean allDay, int projectkey, int memberkey,
			MultipartFile[] uploadFile, ArrayList<String> fnames, int fno) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.start1 = start1;
		this.end = end;
		this.end1 = end1;
		this.content = content;
		this.borderColor = borderColor;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getBorderColor() {
		return borderColor;
	}

	public void setBorderColor(String borderColor) {
		this.borderColor = borderColor;
	}

	public String getBackgroundColor() {
		return backgroundColor;
	}

	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}

	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}

	public boolean isAllDay() {
		return allDay;
	}

	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
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

	public MultipartFile[] getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile[] uploadFile) {
		this.uploadFile = uploadFile;
	}

	public ArrayList<String> getFnames() {
		return fnames;
	}

	public void setFnames(ArrayList<String> fnames) {
		this.fnames = fnames;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getStart1() {
		return start1;
	}

	public void setStart1(String start1) {
		this.start1 = start1;
	}

	public String getEnd1() {
		return end1;
	}

	public void setEnd1(String end1) {
		this.end1 = end1;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
