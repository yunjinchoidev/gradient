package project5.chatting;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ChattingDao {

	//회원초대
	public void roomJoin(ChatJoinVO vo);
	
	//메시지 삭제
	public void DeleteMessagebyMessagekey(int messagekey);
	
	// 방 번호로 룸별 메시지 가져오기
	public List<ChattingMessageVO> MessageListbyRoomkey(int roomkey);

	
	// 메시지 보내기 (디비 저장)
	public void createMessage(ChattingMessageVO vo);

	
	// 채팅방 만들기
	public void createChat(String name);
	
	//방제로 만들기
	public void createChat2(String name);
	
	// 채팅방목록 불러오기
	public List<ChattingRoomVO> chatRoomList();

	//채팅방 하나 이름 가져오기
	public ChattingRoomVO getChatRoom(int roomkey);
	
	// 좋아요
	public void plusLikeCnt(int messagekey);
	
	// 최근 채팅방 번호 가져오기
	public int chatRoomMax();

	// 방 이름 바꾸기
	public void ChattingRoomNameUpdate(ChattingRoomVO vo);
	
}
