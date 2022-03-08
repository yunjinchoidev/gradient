package project5.communication;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommuniList {
	
	@RequestMapping("/conference.do")
	public String conference() {
		return "communication/conference";
	}

	@RequestMapping("/chat.do")
	public String chat() {
		return "communication/chat";
	}

	
	
	
}
