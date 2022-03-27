package project5.custoChat;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface CustoChatDao {

	//회원초대
	public void roomJoin(CustoChatRoomJoinVO vo);

	
	//메시지 삭제
	public void DeleteMessagebyMessagekey(int messagekey);

	//
	public List<CustoChatMessageVO> MessageListbyRoomkey(int roomkey);
	public List<CustoChatMessageVO> AllMessage();

	
	// 메시지 보내기 (디비 저장)
	public void createMessage(CustoChatMessageVO vo);

	// 채팅방 만들기
	public void createChat(CustoChatRoomVO vo);

	// 채팅방 불러오기
	public List<CustoChatRoomVO> chatRoomList();

	
	//채팅방 하나 이름 가져오기
	public CustoChatRoomVO getChatRoom(int roomkey);
	
	
	public void plusLikeCnt(int messagekey);
	

}
