package project5.communication;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class chatController {
	//// http://localhost:7080/project5/chat.do
	@RequestMapping("/chat.do")
	public String chatmain() {
		return "WEB-INF\\views\\communication\\chatmain.jsp";
	}
	
	@RequestMapping("/chatroom.do")
	public String chat() {
		return "WEB-INF\\views\\communication\\chat.jsp";
	}
}
