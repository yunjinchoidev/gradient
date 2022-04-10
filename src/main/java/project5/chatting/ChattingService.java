package project5.chatting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChattingService {

	@Autowired
	ChattingDao dao;
	
	//회원초대
	public void roomJoin(ChatJoinVO vo) {
		dao.roomJoin(vo);
	}
	
	//메시지 삭제
	public void DeleteMessagebyMessagekey(int messagekey) {
		dao.DeleteMessagebyMessagekey(messagekey);
	}
	
	// 방 번호로 룸별 메시지 가져오기
	public List<ChattingMessageVO> MessageListbyRoomkey(int roomkey){
		return dao.MessageListbyRoomkey(roomkey);
	}

	
	// 메시지 보내기 (디비 저장)
	public void createMessage(ChattingMessageVO vo) {
		dao.createMessage(vo);
	}

	
	// 채팅방 만들기
	public void createChat() {
		dao.createChat();
	}
	
	//방제로 만들기
	public void createChat2(String name) {
		dao.createChat2(name);
	}
	
	// 채팅방목록 불러오기
	public List<ChattingRoomVO> chatRoomList(int memberkey){
		return dao.chatRoomList(memberkey);
	}

	//채팅방 하나 이름 가져오기
	public ChattingRoomVO getChatRoom(int roomkey) {
		return dao.getChatRoom(roomkey);
	}
	
	// 좋아요
	public void plusLikeCnt(int messagekey) {
		dao.plusLikeCnt(messagekey);
	}
	
	// 최근 채팅방 번호 가져오기
	public int chatRoomMax() {
		return dao.chatRoomMax();
	}

	// 방 이름 바꾸기
	public void ChattingRoomNameUpdate(ChattingRoomVO vo) {
		dao.ChattingRoomNameUpdate(vo);
	}
	public void ChattingRoomNameUpdate2(ChattingRoomVO vo) {
		dao.ChattingRoomNameUpdate2(vo);
	}
}
