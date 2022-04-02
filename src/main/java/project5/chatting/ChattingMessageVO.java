package project5.chatting;

import java.util.Date;

public class ChattingMessageVO {
	private int messagekey;
	private String contents;
	private Date writedate;
	private String writedateS;
	private int memberkey;
	private int projectkey;

	public ChattingMessageVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChattingMessageVO(int messagekey, String contents, Date writedate, String writedateS, int memberkey,
			int projectkey) {
		super();
		this.messagekey = messagekey;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
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

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public int getProjectkey() {
		return projectkey;
	}

	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
	}

}
