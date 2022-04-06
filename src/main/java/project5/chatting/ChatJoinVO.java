package project5.chatting;

public class ChatJoinVO {
	
	int chat_memroom_join_key;
	int roomkey;
	int memberkey;

	public ChatJoinVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatJoinVO(int chat_memroom_join_key, int roomkey, int memberkey) {
		super();
		this.chat_memroom_join_key = chat_memroom_join_key;
		this.roomkey = roomkey;
		this.memberkey = memberkey;
	}
	
	
	
	
	

	public ChatJoinVO(int roomkey, int memberkey) {
		super();
		this.roomkey = roomkey;
		this.memberkey = memberkey;
	}

	public int getChat_memroom_join_key() {
		return chat_memroom_join_key;
	}

	public void setChat_memroom_join_key(int chat_memroom_join_key) {
		this.chat_memroom_join_key = chat_memroom_join_key;
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

}
