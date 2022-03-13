package project5.notice;

import java.util.Date;
import java.util.List;

import lombok.Data;
import project5.noticeAttach.NoticeAttachVO;

@Data
public class NoticeVO2 {
	private int noticekey;
	private String title;
	private String content;
	private int cnt;
	private Date writeDate;
	private String writeDateS;
	private int memberkey;
	private String name;

	private List<NoticeAttachVO> attachList;

	public NoticeVO2() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NoticeVO2(int noticekey, String title, String content, int cnt, Date writeDate, String writeDateS,
			int memberkey, String name, List<NoticeAttachVO> attachList) {
		super();
		this.noticekey = noticekey;
		this.title = title;
		this.content = content;
		this.cnt = cnt;
		this.writeDate = writeDate;
		this.writeDateS = writeDateS;
		this.memberkey = memberkey;
		this.name = name;
		this.attachList = attachList;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<NoticeAttachVO> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<NoticeAttachVO> attachList) {
		this.attachList = attachList;
	}

}