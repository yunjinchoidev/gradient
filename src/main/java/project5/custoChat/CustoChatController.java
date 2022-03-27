package project5.custoChat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import oracle.net.aso.d;

@Controller
public class CustoChatController {
	
	@Autowired
	CustoChatService service;
	
	@RequestMapping("/customerChat.do")
	public String chatting(Model d) {
		d.addAttribute("chatRoomList", service.chatRoomList());
		return "WEB-INF\\views\\customerChat\\main.jsp";
	}
	
	
	// 채팅방 목록 불러오기
	@RequestMapping("/chatRoomList.do")
	public String chatRoomList(Model d) {
		d.addAttribute("chatRoomList", service.chatRoomList());
		return "pageJsonReport";
	}
	
	
	// 회원 초대하기
	@RequestMapping("/roomJoin.do")
	public String roomJoin(Model d, CustoChatRoomJoinVO vo) {
		service.roomJoin(vo);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	
	
	@RequestMapping("/DeleteMessagebyMessagekey.do")
	public String DeleteMessagebyMessagekey(Model d, int messagekey) {
		service.DeleteMessagebyMessagekey(messagekey);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	
	
	// 메시지 불러오기
	@RequestMapping("/MessageListbyRoomkey.do")
	public String MessageListbyRoomkey(Model d, int roomkey) {
		d.addAttribute("MessageListbyRoomkey", service.MessageListbyRoomkey(roomkey));
		return "pageJsonReport";
	}
	
	
	
	
	// 메시지 삽입
	@RequestMapping("/createMessage.do")
	public String createMessage(Model d,CustoChatMessageVO vo) {
		System.out.println("createMessage 진입");
		System.out.println(vo.getRoomkey());
		System.out.println(vo.getMemberkey());
		System.out.println(vo.getMessage());
		service.createMessage(vo);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	
	
	
	
	
	@RequestMapping("/createChat.do")
	public String  createChat(Model d, CustoChatRoomVO vo) {
		service.createChat(vo);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	
	@RequestMapping("/getChatRoom.do")
	public String  getChatRoom(Model d, int roomkey) {
		d.addAttribute("getChatRoom", service.getChatRoom(roomkey));
		return "pageJsonReport";
	}

	@RequestMapping("/plusLikeCnt.do")
	public String  plusLikeCnt(Model d, int  messagekey) {
		 service.plusLikeCnt(messagekey);
		d.addAttribute("psc","plusLikeCntSuccess");
		return "pageJsonReport";
	}
	


	
	
}
