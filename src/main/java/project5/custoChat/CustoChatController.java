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
	
	
	
	
	
	@RequestMapping("/roomJoin.do")
	public String roomJoin(Model d, CustoChatRoomJoinVO vo) {
		service.roomJoin(vo);
		return "pageJsonReport";
	}
	
	
	@RequestMapping("/DeleteMessagebyMessagekey.do")
	public String DeleteMessagebyMessagekey(Model d, int messagekey) {
		service.DeleteMessagebyMessagekey(messagekey);
		return "success";
	}
	
	@RequestMapping("/MessageListbyRoomkey.do")
	public String MessageListbyRoomkey(Model d, int roomkey) {
		service.MessageListbyRoomkey(roomkey);
		return "pageJsonReport";
	}
	
	
	@RequestMapping("/createMessage.do")
	public String createMessage(Model d,CustoChatMessageVO vo) {
		service.createMessage(vo);
		return "success";
	}
	
	
	
	
	@RequestMapping("/createChat.do")
	public String  createChat(Model d, CustoChatRoomVO vo) {
		service.createChat(vo);
		return "success";
	}
	
	
	@RequestMapping("/chatRoomList.do")
	public String  chatRoomList(Model d) {
		d.addAttribute("chatRoomList", service.chatRoomList());
		return "pageJsonReport";
	}
	@RequestMapping("/getChatRoom.do")
	public String  getChatRoom(Model d, int roomkey) {
		d.addAttribute("getChatRoom", service.getChatRoom(roomkey));
		return "pageJsonReport";
	}
	


	
	
}
