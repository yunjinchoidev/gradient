package project5.project;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ProjectVO {
	private int projectkey;
	private String name;
	private Date term;
	private String termS;
	private int take;
	private String manager;
	private String progress;
	private String importance;
	private String contents;
	private int clientkey;
	private Date startdate;
	private String startdateS;
	private Date lastdate;
	private String lastdateS;
	private String quality;
	
	
	private MultipartFile[] uploadFile;

	private ArrayList<String> fnames;
	private int fno;
	
	
	
	public ProjectVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProjectVO(int projectkey, String name, Date term, String termS, int take, String manager, String progress,
			String importance, String contents, int clientkey, Date startdate, String startdateS, Date lastdate,
			String lastdateS) {
		super();
		this.projectkey = projectkey;
		this.name = name;
		this.term = term;
		this.termS = termS;
		this.take = take;
		this.manager = manager;
		this.progress = progress;
		this.importance = importance;
		this.contents = contents;
		this.clientkey = clientkey;
		this.startdate = startdate;
		this.startdateS = startdateS;
		this.lastdate = lastdate;
		this.lastdateS = lastdateS;
	}
	
	
	
	
	public ProjectVO(int projectkey, String name, Date term, String termS, int take, String manager, String progress,
			String importance, String contents, int clientkey, Date startdate, String startdateS, Date lastdate,
			String lastdateS, String quality, MultipartFile[] uploadFile, ArrayList<String> fnames, int fno) {
		super();
		this.projectkey = projectkey;
		this.name = name;
		this.term = term;
		this.termS = termS;
		this.take = take;
		this.manager = manager;
		this.progress = progress;
		this.importance = importance;
		this.contents = contents;
		this.clientkey = clientkey;
		this.startdate = startdate;
		this.startdateS = startdateS;
		this.lastdate = lastdate;
		this.lastdateS = lastdateS;
		this.quality = quality;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
	}
	public int getProjectkey() {
		return projectkey;
	}
	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getTerm() {
		return term;
	}
	public void setTerm(Date term) {
		this.term = term;
	}
	public String getTermS() {
		return termS;
	}
	public void setTermS(String termS) {
		this.termS = termS;
	}
	public int getTake() {
		return take;
	}
	public void setTake(int take) {
		this.take = take;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getClientkey() {
		return clientkey;
	}
	public void setClientkey(int clientkey) {
		this.clientkey = clientkey;
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
	public Date getLastdate() {
		return lastdate;
	}
	public void setLastdate(Date lastdate) {
		this.lastdate = lastdate;
	}
	public String getLastdateS() {
		return lastdateS;
	}
	public void setLastdateS(String lastdateS) {
		this.lastdateS = lastdateS;
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
	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
	}
	
	


}