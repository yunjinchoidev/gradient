package project5.custoChat;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.awt.geom.CubicCurve2D;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import oracle.net.aso.a;
import oracle.net.aso.d;
import project5.member.MemberService;
import project5.member.MemberVO;

@Controller
public class CustoChatController {

	@Autowired
	CustoChatService service;

	@Autowired
	MemberService service2;

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
	public String createMessage(Model d, CustoChatMessageVO vo) {
		System.out.println("createMessage 진입");
		System.out.println(vo.getRoomkey());
		System.out.println(vo.getMemberkey());
		System.out.println(vo.getMessage());
		service.createMessage(vo);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}

	@RequestMapping("/createChat.do")
	public String createChat(Model d) {
		service.createChat();
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}

	@RequestMapping("/getChatRoom.do")
	public String getChatRoom(Model d, int roomkey) {
		d.addAttribute("getChatRoom", service.getChatRoom(roomkey));
		return "pageJsonReport";
	}

	@RequestMapping("/plusLikeCnt.do")
	public String plusLikeCnt(Model d, int messagekey) {
		service.plusLikeCnt(messagekey);
		d.addAttribute("psc", "plusLikeCntSuccess");
		return "pageJsonReport";
	}

	// 1:1 대화하기
	@RequestMapping("/invitationList.do")
	public String invitationList(Model d, int memberkey) {
		service.createChat2(service2.get(memberkey).getName() + ",");
		d.addAttribute("list", service2.list());
		return "WEB-INF\\views\\customerChat\\list.jsp";
	}

	@RequestMapping("/groupInvitation.do")
	public String groupInvitation(Model d, @RequestParam HashMap<String, Object> commandMap) throws Exception {
		d.addAttribute("psc", "groupInvitationSuccess");
		d.addAttribute("list", service2.list());
		String[] code_array = null;
		String code = commandMap.get("arrayParam").toString();
		code_array = code.split(",");
		ArrayList<String> results2 = new ArrayList<String>();
		for (int i = 0; i < code_array.length; i++) {
			results2.add(code_array[i]);
		}
		int A = service.chatRoomMax();
		d.addAttribute("list", commandMap);
		d.addAttribute("results", results2);
		for (int i = 0; i < results2.size(); i++) {
			service.roomJoin(new CustoChatRoomJoinVO(Integer.parseInt(results2.get(i)), A));
			d.addAttribute("groupInvitation" + i,
					A + "번 방에 " + service2.get(Integer.parseInt(results2.get(i))).getName() + "님을 초대했습니다.");
			System.out.println("groupInvitation[" + i + "]" + A + "번 방에 "
					+ service2.get(Integer.parseInt(results2.get(i))).getName() + "님을 초대했습니다.");
			CustoChatRoomVO vo4 = new CustoChatRoomVO(A, service2.get(Integer.parseInt(results2.get(i))).getName());
			service.custoChatRoomNameUpdate(vo4);
		}
		d.addAttribute("RoomNAme", service.getChatRoom(A).getName());
		System.out.println("단톡 만들기 종료");
		return "forward:/customerChat.do";
	}

	// 1:1 대화 만들기
	@RequestMapping("/individualInvitation.do")
	public String individualInvitation(Model d, int memberkey) {
		MemberVO vo2 = service2.get(memberkey);
		int roomkey = service.chatRoomMax();
		System.out.println(roomkey);
		CustoChatRoomVO vo4 = new CustoChatRoomVO(roomkey, vo2.getName());
		service.custoChatRoomNameUpdate(vo4);
		service.roomJoin(new CustoChatRoomJoinVO(memberkey, roomkey));
		d.addAttribute("individualInvitation", roomkey + "번 방에 " + vo2.getName() + "님을 초대했습니다. 방 이름:");
		d.addAttribute("RoomNAme", service.getChatRoom(roomkey).getName());
		return "forward:/customerChat.do";
	}

}
