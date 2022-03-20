package project5.notice;

import java.util.Date;
import java.util.List;

import lombok.Data;
import project5.noticeAttach.NoticeAttachVO;

@Data
public class NoticeVO2 {
	
	private int cnt;
	private int level;
	private int noticekey;
	private int refno;
	private String title;
	private String content;
	private int views;
	private Date writeDate;
	private String writeDateS;
	private int memberkey;
	private String name;
	
	
	
	
	
	public NoticeVO2() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NoticeVO2(int cnt, int level, int noticekey, int refno, String title, String content, int views,
			Date writeDate, String writeDateS, int memberkey, String name) {
		super();
		this.cnt = cnt;
		this.level = level;
		this.noticekey = noticekey;
		this.refno = refno;
		this.title = title;
		this.content = content;
		this.views = views;
		this.writeDate = writeDate;
		this.writeDateS = writeDateS;
		this.memberkey = memberkey;
		this.name = name;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getNoticekey() {
		return noticekey;
	}
	public void setNoticekey(int noticekey) {
		this.noticekey = noticekey;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getWriteDateS() {
		return writeDateS;
	}
	public void setWriteDateS(String writeDateS) {
		this.writeDateS = writeDateS;
	}
	public int getMemberkey() {
		return memberkey;
	}
	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	
	
	
	
}