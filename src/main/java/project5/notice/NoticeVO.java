package project5.notice;

import java.util.Date;
import java.util.List;

import lombok.Data;
import project5.noticeAttach.NoticeAttachVO;

@Data
public class NoticeVO {
	private int noticekey;
	private String title;
	private String content;
	private int cnt;
	private Date writeDate;
	private String writeDateS;
	private int memberkey;

	
	private List<NoticeAttachVO> attachList;
	
	
	
	
	
	
	
	
	
	public NoticeVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NoticeVO(int noticekey, String title, String content, int cnt, Date writeDate, String writeDateS,
			int memberkey) {
		super();
		this.noticekey = noticekey;
		this.title = title;
		this.content = content;
		this.cnt = cnt;
		this.writeDate = writeDate;
		this.writeDateS = writeDateS;
		this.memberkey = memberkey;
	}

	public NoticeVO(int noticekey, String title, String content, int cnt, String writeDateS, int memberkey) {
		super();
		this.noticekey = noticekey;
		this.title = title;
		this.content = content;
		this.cnt = cnt;
		this.writeDateS = writeDateS;
		this.memberkey = memberkey;
	}

	public NoticeVO(int noticekey, String title, String content, int cnt, Date writeDate, int memberkey) {
		super();
		this.noticekey = noticekey;
		this.title = title;
		this.content = content;
		this.cnt = cnt;
		this.writeDate = writeDate;
		this.memberkey = memberkey;
	}

	public int getNoticekey() {
		return noticekey;
	}

	public void setNoticekey(int noticekey) {
		this.noticekey = noticekey;
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

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
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

	public List<NoticeAttachVO> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<NoticeAttachVO> attachList) {
		this.attachList = attachList;
	}
	
	

}