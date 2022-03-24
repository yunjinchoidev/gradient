package project5.custoChat;

public class CustoChatRoomJoinVO {
	private int roomjoinkey;
	private int memberkey;
	private int roomkey;

	public CustoChatRoomJoinVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustoChatRoomJoinVO(int roomjoinkey, int memberkey, int roomkey) {
		super();
		this.roomjoinkey = roomjoinkey;
		this.memberkey = memberkey;
		this.roomkey = roomkey;
	}

	public int getRoomjoinkey() {
		return roomjoinkey;
	}

	public void setRoomjoinkey(int roomjoinkey) {
		this.roomjoinkey = roomjoinkey;
	}

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public int getRoomkey() {
		return roomkey;
	}

	public void setRoomkey(int roomkey) {
		this.roomkey = roomkey;
	}

}
