package project5.wbs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WbsController {
	
	@RequestMapping("/wbs.do")
	public String unifyIndex() {
		return "wbs/list";
	}
	
}
