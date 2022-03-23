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

	public void createMessage(CustoChatMessageVO vo) {
		dao.createMessage(vo);
	}
	

	public void createChat(CustoChatRoomVO vo) {
		dao.createChat(vo);
	}

	public List<CustoChatRoomVO> chatRoomList(){
		return dao.chatRoomList();
	}

	public CustoChatRoomVO getChatRoom(int roomkey) {
		return dao.getChatRoom(roomkey);
	}
	
	
}
