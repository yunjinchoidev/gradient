package project5.vacation;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class VacationVO {
	private int vacationkey;
	private int memberkey;
	private int projectkey;
	private String title;
	private Date startdate;
	private String startdateS;
	private int duration;
	private String contents;

	private MultipartFile[] uploadFile;

	public VacationVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VacationVO(int vacationkey, int memberkey, int projectkey, String title, Date startdate, String startdateS,
			int duration, String contents, MultipartFile[] uploadFile) {
		super();
		this.vacationkey = vacationkey;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.title = title;
		this.startdate = startdate;
		this.startdateS = startdateS;
		this.duration = duration;
		this.contents = contents;
		this.uploadFile = uploadFile;
	}

	public int getVacationkey() {
		return vacationkey;
	}

	public void setVacationkey(int vacationkey) {
		this.vacationkey = vacationkey;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public String getStartdateS() {
		return startdateS;
	}

	public void setStartdateS(String startdateS) {
		this.startdateS = startdateS;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public MultipartFile[] getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile[] uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	
}
	