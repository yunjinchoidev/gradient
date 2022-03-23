package project5.custoChat;

import java.util.Date;

public class CustoChatMessageVO {
	private int messagekey;
	private String message;
	private Date writedate;
	private String writedateS;
	private int memberkey;
	private int roomKey;
	
	public CustoChatMessageVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustoChatMessageVO(int messagekey, String message, Date writedate, String writedateS, int memberkey,
			int roomKey) {
		super();
		this.messagekey = messagekey;
		this.message = message;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.memberkey = memberkey;
		this.roomKey = roomKey;
	}

	public int getMessagekey() {
		return messagekey;
	}

	public void setMessagekey(int messagekey) {
		this.messagekey = messagekey;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public int getRoomKey() {
		return roomKey;
	}

	public void setRoomKey(int roomKey) {
		this.roomKey = roomKey;
	}

}
