package project5.custoChat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustoChatService {

	@Autowired
	CustoChatDao dao;
	
	public void roomJoin(CustoChatRoomJoinVO vo) {
		dao.roomJoin(vo);
	}

	public void DeleteMessagebyMessagekey(int messagekey) {
		dao.DeleteMessagebyMessagekey(messagekey);
	}

	public List<CustoChatMessageVO> MessageListbyRoomkey(int roomkey){
		return dao.MessageListbyRoomkey(roomkey);
	}

	public List<CustoChatMessageVO> AllMessage(){
		return dao.AllMessage();
	}
	
	
	public void createMessage(CustoChatMessageVO vo) {
		dao.createMessage(vo);
		System.out.println("서비스단도 성공");
	}
	

	public void createChat() {
		dao.createChat();
	}

	
	public void createChat2(String name) {
		dao.createChat2(name);
	}
	
	public List<CustoChatRoomVO> chatRoomList(){
		return dao.chatRoomList();
	}

	public CustoChatRoomVO getChatRoom(int roomkey) {
		return dao.getChatRoom(roomkey);
	}
	
	public void plusLikeCnt(int messagekey) {
		dao.plusLikeCnt(messagekey);
	}
	
	
	// 최근 채팅방 번호 가져오기
	public int chatRoomMax() {
		return dao.chatRoomMax();
	}
	
	public void custoChatRoomNameUpdate(CustoChatRoomVO vo) {
		dao.custoChatRoomNameUpdate(vo);
	}
	
}
