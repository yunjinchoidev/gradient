package project5.chatBot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatBotController {

	@Autowired
	ChatBotService service;
	
	@RequestMapping("/chatBot.do")
	public String chatBot(Model d) {
		return "WEB-INF\\views\\chatBot\\chatBot.jsp";
	}
	
	@RequestMapping("/chatBotTest.do")
	public String chatBotTest(Model d) {
		return "WEB-INF\\views\\chatBot\\chatBotTest.jsp";
	}

	
	@RequestMapping("/getbyInputData.do")
	public String chatAutoAnswer(Model d, String inputdata) {
		d.addAttribute("answer", service.getbyInputData(inputdata));
		d.addAttribute("psc", "success");
		return "pageJsonReport";
	}
	
	
	
	
	
}
