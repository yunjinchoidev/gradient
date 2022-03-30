package project5.attendance;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class AttendanceVO2 {
	private int memberkey;
	private String id;
	private String pass;
	private String name;
	private String auth;
	private int projectkey;
	private int deptno;
	private String email;
	private int status;
	private int score;

	public AttendanceVO2() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AttendanceVO2(int memberkey, String id, String pass, String name, String auth, int projectkey, int deptno,
			String email, int status, int score) {
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
		this.score = score;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

}