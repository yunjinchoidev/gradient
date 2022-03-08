package project5.support;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SupportController {
	
	@RequestMapping("/support.do")
	public String unifyIndex() {
		return "support/list";
	}

	
	
	
	
}
