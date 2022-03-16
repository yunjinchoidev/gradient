package project5.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class A11_ChattingController {
	
	@GetMapping("/chatting.do")
	public String chatting() {
		return "/chat/a11_chatting";
		
		
		
		
	}
}
