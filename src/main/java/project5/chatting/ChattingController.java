package project5.chatting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChattingController {

	@Autowired
	ChattingService service;
	
	@RequestMapping("/chatting.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\chatting\\main.jsp";
	}
	
	
	
	
	
	
}
