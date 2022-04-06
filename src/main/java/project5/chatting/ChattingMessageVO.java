package project5.chatting;

import java.util.Date;

public class ChattingMessageVO {
	private int messagekey;
	private String contents;
	private Date writedate;
	private String writedateS;
	private int roomkey;
	private int memberkey;
	private int likecnt;
	public ChattingMessageVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ChattingMessageVO(int messagekey, String contents, Date writedate, String writedateS, int roomkey,
			int memberkey, int likecnt) {
		super();
		this.messagekey = messagekey;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.roomkey = roomkey;
		this.memberkey = memberkey;
		this.likecnt = likecnt;
	}
	public int getMessagekey() {
		return messagekey;
	}
	public void setMessagekey(int messagekey) {
		this.messagekey = messagekey;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public String getWritedateS() {
		return writedateS;
	}
	public void setWritedateS(String writedateS) {
		this.writedateS = writedateS;
	}
	public int getRoomkey() {
		return roomkey;
	}
	public void setRoomkey(int roomkey) {
		this.roomkey = roomkey;
	}
	public int getMemberkey() {
		return memberkey;
	}
	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}
	public int getLikecnt() {
		return likecnt;
	}

	public void setLikecnt(int likecnt) {
		this.likecnt = likecnt;
	}




}
