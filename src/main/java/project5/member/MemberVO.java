package project5.member;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private int memberkey;
	private String id;
	private String pass;
	private String name;
	private String auth;
	private int projectkey;
	private int deptno;
	private String email;
	private int status;
	private int pricing;
	private int visitcnt;

	private List<String> emailList;

	private MultipartFile[] uploadFile;

	private ArrayList<String> fnames;
	private int fno;

	private List<AuthVO> authList;

	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
	
	
	
	

	public MemberVO(int memberkey, int status) {
		super();
		this.memberkey = memberkey;
		this.status = status;
	}









	public MemberVO(List<String> emailList) {
		super();
		this.emailList = emailList;
	}

	public List<String> getEmailList() {
		return emailList;
	}

	public void setEmailList(List<String> emailList) {
		this.emailList = emailList;
	}

	public MemberVO(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email, MultipartFile[] uploadFile, ArrayList<String> fnames) {
		super();
		this.memberkey = memberkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.projectkey = projectkey;
		this.deptno = deptno;
		this.email = email;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
	}

	public MemberVO(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email, int status, List<String> emailList, MultipartFile[] uploadFile, ArrayList<String> fnames,
			int fno, List<AuthVO> authList) {
		super();
		this.memberkey = memberkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.projectkey = projectkey;
		this.deptno = deptno;
		this.email = email;
		this.status = status;
		this.emailList = emailList;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
		this.authList = authList;
	}

	public MemberVO(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email, int status, int pricing, int visitcnt, List<String> emailList, MultipartFile[] uploadFile,
			ArrayList<String> fnames, int fno, List<AuthVO> authList) {
		super();
		this.memberkey = memberkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.projectkey = projectkey;
		this.deptno = deptno;
		this.email = email;
		this.status = status;
		this.pricing = pricing;
		this.visitcnt = visitcnt;
		this.emailList = emailList;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
		this.authList = authList;
	}

	public MemberVO(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email) {
		super();
		this.memberkey = memberkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.projectkey = projectkey;
		this.deptno = deptno;
		this.email = email;
	}

	public MemberVO(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email, List<String> emailList, MultipartFile[] uploadFile, ArrayList<String> fnames, int fno,
			List<AuthVO> authList) {
		super();
		this.memberkey = memberkey;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.auth = auth;
		this.projectkey = projectkey;
		this.deptno = deptno;
		this.email = email;
		this.emailList = emailList;
		this.uploadFile = uploadFile;
		this.fnames = fnames;
		this.fno = fno;
		this.authList = authList;
	}

	public MemberVO(int deptno) {
		super();
		this.deptno = deptno;
	}

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public int getProjectkey() {
		return projectkey;
	}

	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public List<AuthVO> getAuthList() {
		return authList;
	}

	public void setAuthList(List<AuthVO> authList) {
		this.authList = authList;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getPricing() {
		return pricing;
	}

	public void setPricing(int pricing) {
		this.pricing = pricing;
	}

	public int getVisitcnt() {
		return visitcnt;
	}

	public void setVisitcnt(int visitcnt) {
		this.visitcnt = visitcnt;
	}


}
