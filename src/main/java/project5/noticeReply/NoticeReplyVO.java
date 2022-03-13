package project5.noticeReply;

import java.util.Date;

public class NoticeReplyVO {
	private int rno;
	private int noticekey;

	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	
	
	
	
	
	
	
	public NoticeReplyVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NoticeReplyVO(int rno, int noticekey, String reply, String replyer, Date replyDate, Date updateDate) {
		super();
		this.rno = rno;
		this.noticekey = noticekey;
		this.reply = reply;
		this.replyer = replyer;
		this.replyDate = replyDate;
		this.updateDate = updateDate;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getNoticekey() {
		return noticekey;
	}
	public void setNoticekey(int noticekey) {
		this.noticekey = noticekey;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	
	
	
}
