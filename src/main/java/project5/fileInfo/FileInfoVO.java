package project5.fileInfo;
//project5.fileInfo.FileInfoVO
import java.util.Date;

public class FileInfoVO {

	private int fno;
	private String pathinfo;
	private String fname;
	private Date regdte;
	private Date uptdte;
	private String etc;

	public FileInfoVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FileInfoVO(String pathinfo, String fname, String etc) {
		super();
		this.pathinfo = pathinfo;
		this.fname = fname;
		this.etc = etc;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public FileInfoVO(int fno, String pathinfo, String fname, String etc) {
		super();
		this.fno = fno;
		this.pathinfo = pathinfo;
		this.fname = fname;
		this.etc = etc;
	}

	public FileInfoVO(int fno, String pathinfo, String fname, Date regdte, Date uptdte, String etc) {
		super();
		this.fno = fno;
		this.pathinfo = pathinfo;
		this.fname = fname;
		this.regdte = regdte;
		this.uptdte = uptdte;
		this.etc = etc;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getPathinfo() {
		return pathinfo;
	}

	public void setPathinfo(String pathinfo) {
		this.pathinfo = pathinfo;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public Date getRegdte() {
		return regdte;
	}

	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}

	public Date getUptdte() {
		return uptdte;
	}

	public void setUptdte(Date uptdte) {
		this.uptdte = uptdte;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	

}
