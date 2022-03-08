package project5.unifyStart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UnifyStartController {
	
	@RequestMapping("/unifyStart.do")
	public String unifyIndex() {
		return "unify/start/list";
	}
	
}
