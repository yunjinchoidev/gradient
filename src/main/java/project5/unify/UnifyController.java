package project5.unify;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UnifyController {
	
	@RequestMapping("/unifyIndex.do")
	public String unifyIndex() {
		return "unify/index";
	}
	
	
	
	
}
