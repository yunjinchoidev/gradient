package project5.communication;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class chatController {
	@RequestMapping("/chat.do")
	public String chat() {
		return "WEB-INF\\views\\communication\\chat.jsp";
	}

	@RequestMapping("/chat3.do")
	public String chat3() {
		return "WEB-INF\\views\\communication\\main.jsp";
	}
	
}
