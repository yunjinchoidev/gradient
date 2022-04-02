package project5.chatting;

import java.util.Date;

public class ChattingRoomVO {
	private int roomkey;
	private String name;
	private Date makedate;
	private String makedateS;

	
	
	
	
	
	
	
	
	
	public ChattingRoomVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChattingRoomVO(int roomkey, String name, Date makedate, String makedateS) {
		super();
		this.roomkey = roomkey;
		this.name = name;
		this.makedate = makedate;
		this.makedateS = makedateS;
	}

	
	
	
	
	
	public ChattingRoomVO(int roomkey, String name) {
		super();
		this.roomkey = roomkey;
		this.name = name;
	}

	public int getRoomkey() {
		return roomkey;
	}

	public void setRoomkey(int roomkey) {
		this.roomkey = roomkey;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getMakedate() {
		return makedate;
	}

	public void setMakedate(Date makedate) {
		this.makedate = makedate;
	}

	public String getMakedateS() {
		return makedateS;
	}

	public void setMakedateS(String makedateS) {
		this.makedateS = makedateS;
	}

}
