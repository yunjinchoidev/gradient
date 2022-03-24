package project5.custoChat;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface CustoChatDao {

	public void roomJoin(CustoChatRoomJoinVO vo);

	public void DeleteMessagebyMessagekey(int messagekey);

	public List<CustoChatMessageVO> MessageListbyRoomkey(int roomkey);

	public void createMessage(CustoChatMessageVO vo);

	public void createChat(CustoChatRoomVO vo);

	public List<CustoChatRoomVO> chatRoomList();

	public CustoChatRoomVO getChatRoom(int roomkey);

}
