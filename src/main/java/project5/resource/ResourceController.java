package project5.resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ResourceController {
	
	@RequestMapping("/communiList.do")
	public String unifyIndex() {
		return "communication/list";
	}

	
	
	
	
}
