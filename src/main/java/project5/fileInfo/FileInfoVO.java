package project5.fileInfo;

import java.util.Date;

public class FileInfoVO {
	private int fno;
	private String pathInfo;
	private String fname;
	private Date regDate;
	private String regDateS;
	private Date upDate;
	private String upDateS;
	private String etc;

	public FileInfoVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FileInfoVO(int fno, String pathInfo, String fname, Date regDate, String regDateS, Date upDate, String upDateS,
			String etc) {
		super();
		this.fno = fno;
		this.pathInfo = pathInfo;
		this.fname = fname;
		this.regDate = regDate;
		this.regDateS = regDateS;
		this.upDate = upDate;
		this.upDateS = upDateS;
		this.etc = etc;
	}

	public FileInfoVO(int fno, String pathInfo, String fname, String regDateS, String upDateS, String etc) {
		super();
		this.fno = fno;
		this.pathInfo = pathInfo;
		this.fname = fname;
		this.regDateS = regDateS;
		this.upDateS = upDateS;
		this.etc = etc;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getPathInfo() {
		return pathInfo;
	}

	public void setPathInfo(String pathInfo) {
		this.pathInfo = pathInfo;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getRegDateS() {
		return regDateS;
	}

	public void setRegDateS(String regDateS) {
		this.regDateS = regDateS;
	}

	public Date getUpDate() {
		return upDate;
	}

	public void setUpDate(Date upDate) {
		this.upDate = upDate;
	}

	public String getUpDateS() {
		return upDateS;
	}

	public void setUpDateS(String upDateS) {
		this.upDateS = upDateS;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

}
