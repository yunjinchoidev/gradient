package project5.chatbot;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatbotController {

	
	@RequestMapping("/chatBot.do")
	public String chatBot(Model d) {
		return "/chatBot/main";
	}
}
