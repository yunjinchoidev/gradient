package project5.chatting;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project5.custoChat.CustoChatMessageVO;
import project5.custoChat.CustoChatRoomJoinVO;
import project5.custoChat.CustoChatRoomVO;
import project5.member.MemberSch;
import project5.member.MemberService;
import project5.member.MemberVO;

@Controller
public class ChattingController {

	@Autowired
	ChattingService service;
	
	@Autowired
	MemberService service2;
	
	@RequestMapping("/chatting.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\chatting\\main.jsp";
	}

	// 채팅방 목록 불러오기
	@RequestMapping("/chattingRoomList.do")
	public String chattingRoomList(Model d, int memberkey) {
		d.addAttribute("chatRoomList", service.chatRoomList(memberkey));
		return "pageJsonReport";
	}

	
	
	// 메시지 삽입
	@RequestMapping("/chattingCreateMessage.do")
	public String createMessage(Model d, ChattingMessageVO vo) {
		System.out.println("createMessage 진입");
		System.out.println(vo.getRoomkey());
		service.createMessage(vo);
		System.out.println("메시지 넣기");
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	
	
	
	// 회원 초대하기
	@RequestMapping("/chattingRoomJoin.do")
	public String chattingRoomJoin(Model d, ChatJoinVO vo) {
		service.roomJoin(vo);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}

	
	
	@RequestMapping("/chattingMessageDelete.do")
	public String DeleteMessagebyMessagekey(Model d, int messagekey) {
		service.DeleteMessagebyMessagekey(messagekey);
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	

	// 메시지 불러오기
	@RequestMapping("/chattingMListbyRoomkey.do")
	public String chattingMListbyRoomkey(Model d, int roomkey) {
		d.addAttribute("MessageListbyRoomkey", service.MessageListbyRoomkey(roomkey));
		return "pageJsonReport";
	}

	

	

	@RequestMapping("/chattingCreateChatForm.do")
	public String chattingCreateChatForm(Model d) {
		return "WEB-INF\\views\\chatting\\list.jsp";
	}
	
	@RequestMapping("/chattingCreateChat.do")
	public String chattingCreateChat(Model d, int memberkey) {
		service.createChat();
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	

	@RequestMapping("/chattingGetChatRoom.do")
	public String chattingGetChatRoom(Model d, int roomkey) {
		d.addAttribute("getChatRoom", service.getChatRoom(roomkey));
		return "pageJsonReport";
	}

	@RequestMapping("/chattingplusLikeCnt.do")
	public String plusLikeCnt(Model d, int messagekey) {
		service.plusLikeCnt(messagekey);
		d.addAttribute("psc", "plusLikeCntSuccess");
		return "pageJsonReport";
	}

	
	// 1:1 대화하기 // 단체 대화
	@RequestMapping("/chattingInvitationList.do")
	public String chattingInvitationList(Model d, MemberSch sch) {
		d.addAttribute("list", service2.listWithPaging2(sch));
		return "WEB-INF\\views\\chatting\\list.jsp";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/chattingGroupInvitation.do")
	public String chattingGroupInvitation(Model d, @RequestParam HashMap<String, Object> commandMap) throws Exception {
		service.createChat();
		d.addAttribute("psc", "groupInvitationSuccess");
		String[] code_array = null;
		String code = commandMap.get("arrayParam").toString();
		code_array = code.split(",");
		ArrayList<String> results2 = new ArrayList<String>();
		for (int i = 0; i < code_array.length; i++) {
			results2.add(code_array[i]);
		}
		int A = service.chatRoomMax();
		d.addAttribute("list", commandMap);
		d.addAttribute("results2", results2);
		
		for (int i = 0; i < results2.size(); i++) {
			System.out.println(results2.get(i));
			service.roomJoin(new ChatJoinVO(A, Integer.parseInt(results2.get(i))));
			service.ChattingRoomNameUpdate(new ChattingRoomVO(A, service2.get(Integer.parseInt(results2.get(i))).getName()));
		}
		
		service.ChattingRoomNameUpdate2(new ChattingRoomVO(A, "의 새 대화"));
		
		d.addAttribute("RoomNAme", service.getChatRoom(A).getName());
		System.out.println("단톡 만들기 종료");
		//return "pageJsonReport";
		return "forward:/chatting.do";
	}

	
	
	
	
	
	
	
	

	// 1:1 대화 만들기
	@RequestMapping("/chattingIndividualInvitation.do")
	public String chattingIndividualInvitation(Model d, int memberkey) {
		service.createChat2(service2.get(memberkey).getName());
		MemberVO vo2 = service2.get(memberkey);
		int roomkey = service.chatRoomMax();
		System.out.println(roomkey);
		ChattingRoomVO vo4 = new ChattingRoomVO(roomkey, vo2.getName());
		//service.ChattingRoomNameUpdate(vo4);
		service.roomJoin(new ChatJoinVO(memberkey, roomkey));
		d.addAttribute("individualInvitation", roomkey + "번 방에 " + vo2.getName() + "님을 초대했습니다. 방 이름:");
		d.addAttribute("RoomNAme", service.getChatRoom(roomkey).getName());
		return "forward:/chatting.do";
	}

	
	
	
	
	
	
	
	
	
}
