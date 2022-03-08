package project5.communication;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommuniList {
	
	@RequestMapping("/communiList.do")
	public String unifyIndex() {
		return "communication/list";
	}

	
	
	
	
}
