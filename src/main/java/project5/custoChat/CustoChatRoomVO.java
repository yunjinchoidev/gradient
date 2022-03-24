package project5.custoChat;

public class CustoChatRoomVO {
	private int roomkey;
	private String name;
	public CustoChatRoomVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CustoChatRoomVO(int roomkey, String name) {
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



}
