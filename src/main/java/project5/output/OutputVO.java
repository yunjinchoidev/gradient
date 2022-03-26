package project5.output;

import java.util.ArrayList;
import java.util.Date;

import javax.mail.Multipart;

import org.springframework.web.multipart.MultipartFile;

public class OutputVO {
	private int outputkey;
	private String title;
	private String contents;
	private int version;
	private String status;
	private Date writedate;
	private int workSortKey;
	private int projectkey;
	private int memberkey;
	private int deptno;
	private String mname;
	private String worksortTitle;
	private String pname;
	private String dname;
	private int evaluation;

	// 파일을 저장하기 위한
	private MultipartFile[] uploadFile;

	// 파일이름을 불러오기 위한
	private ArrayList<String> fnames;

	public OutputVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OutputVO(int outputkey, String title, String contents, int version, String status, Date writedate,
			int workSortKey, int projectkey, int memberkey, int deptno, String mname, String worksortTitle,
			String pname, String dname) {
		super();
		this.outputkey = outputkey;
		this.title = title;
		this.contents = contents;
		this.version = version;
		this.status = status;
		this.writedate = writedate;
		this.workSortKey = workSortKey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.deptno = deptno;
		this.mname = mname;
		this.worksortTitle = worksortTitle;
		this.pname = pname;
		this.dname = dname;
	}

	public OutputVO(int outputkey, String title, String contents, int version, String status, Date writedate,
			int workSortKey, int projectkey, int memberkey, int deptno, String mname, String worksortTitle,
			String pname, String dname, int evaluation, MultipartFile[] uploadFile, ArrayList<String> fnames) {
		super();
		this.outputkey = outputkey;
		this.title = title;
		this.contents = contents;
		this.version = version;
		this.status = status;
		this.writedate = writedate;
		this.workSortKey = workSortKey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.deptno = deptno;
		this.mname = mname;
		this.worksortTitle = worksortTitle;
		this.pname = pname;
		this.dname = dname;
		this.evaluation = evaluation;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
	}

	public OutputVO(int outputkey, String title, String contents, int version, String status, Date writedate,
			int workSortKey, int projectkey, int memberkey, int deptno, String mname, String worksortTitle,
			String pname, String dname, MultipartFile[] uploadFile, ArrayList<String> fnames) {
		super();
		this.outputkey = outputkey;
		this.title = title;
		this.contents = contents;
		this.version = version;
		this.status = status;
		this.writedate = writedate;
		this.workSortKey = workSortKey;
		this.projectkey = projectkey;
		this.memberkey = memberkey;
		this.deptno = deptno;
		this.mname = mname;
		this.worksortTitle = worksortTitle;
		this.pname = pname;
		this.dname = dname;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
	}

	public int getOutputkey() {
		return outputkey;
	}

	public void setOutputkey(int outputkey) {
		this.outputkey = outputkey;
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

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	public int getWorkSortKey() {
		return workSortKey;
	}

	public void setWorkSortKey(int workSortKey) {
		this.workSortKey = workSortKey;
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

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getWorksortTitle() {
		return worksortTitle;
	}

	public void setWorksortTitle(String worksortTitle) {
		this.worksortTitle = worksortTitle;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
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

	public int getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(int evaluation) {
		this.evaluation = evaluation;
	}

}
