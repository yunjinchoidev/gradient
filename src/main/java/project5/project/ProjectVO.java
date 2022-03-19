package project5.project;

import java.util.Date;

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
	private Date startDate;
	private Date EndDate;

	public ProjectVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProjectVO(int projectkey, String name, Date term, String termS, int take, String manager, String progress,
			String importance, String contents, int clientkey, Date startDate, Date endDate) {
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
		this.startDate = startDate;
		EndDate = endDate;
	}

	public ProjectVO(int projectkey, String name, Date term, int take, String manager, String progress,
			String importance, String contents, int clientkey, Date startDate, Date endDate) {
		super();
		this.projectkey = projectkey;
		this.name = name;
		this.term = term;
		this.take = take;
		this.manager = manager;
		this.progress = progress;
		this.importance = importance;
		this.contents = contents;
		this.clientkey = clientkey;
		this.startDate = startDate;
		EndDate = endDate;
	}

	public ProjectVO(int projectkey, String name, String termS, int take, String manager, String progress,
			String importance, String contents, int clientkey, Date startDate, Date endDate) {
		super();
		this.projectkey = projectkey;
		this.name = name;
		this.termS = termS;
		this.take = take;
		this.manager = manager;
		this.progress = progress;
		this.importance = importance;
		this.contents = contents;
		this.clientkey = clientkey;
		this.startDate = startDate;
		EndDate = endDate;
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return EndDate;
	}

	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}

}