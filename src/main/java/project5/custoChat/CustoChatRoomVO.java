package project5.custoChat;

import java.util.Date;

public class CustoChatRoomVO {
	private int roomkey;
	private String name;
	private Date createDate;
	private String createDateS;

	public CustoChatRoomVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustoChatRoomVO(int roomkey, String name) {
		super();
		this.roomkey = roomkey;
		this.name = name;
	}

	
	
	
	
	public CustoChatRoomVO(String name) {
		super();
		this.name = name;
	}

	public CustoChatRoomVO(int roomkey, String name, Date createDate, String createDateS) {
		super();
		this.roomkey = roomkey;
		this.name = name;
		this.createDate = createDate;
		this.createDateS = createDateS;
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

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCreateDateS() {
		return createDateS;
	}

	public void setCreateDateS(String createDateS) {
		this.createDateS = createDateS;
	}

}
