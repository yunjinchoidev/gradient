package project5.customerChat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomerChatController {
	
	@RequestMapping("/customerChat.do")
	public String chatting() {
		return "WEB-INF\\views\\customerChat\\main.jsp";
	}
	
	
	
	
}
